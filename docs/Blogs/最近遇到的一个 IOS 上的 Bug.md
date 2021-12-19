最近遇到的一个开发上的有趣 Bug
---

#### 写在最前
其实写这篇文章的时候, 距离遇到这个 Bug 以及提出解决方案已经过去几个月了. 这几个月主要是因为懒, 一直没有更新这个 Bug 的情况...

#### 如何发现 Bug
这其实也是很巧, 我们有一个新的 Feature 最近刚刚上线到全公司的某个应用版本上, 本来一切都非常顺利, 没有遇到一个问题. 但是突然间后端的 dev 找到我, 说 IOS 这边 call 后台 API 的 request 数量暴涨, 导致服务器无法承受, 不停的返回 429 的异常 status code.

这乍一听很没有道理, 正因为我们之前考虑过这种情况, 所以在客户端开发时, 已经加入了一个限制, 就是 24 小时内只可能发送一个 request. 但是经过调查, 发现问题的最终原因就是在大部分的机器上存在 5-10 条并发访问的情况.

#### 定位问题
一开始, 我和 IOS Team 的 Partner 开了个会讨论了下, 感觉不太像 IOS SDK 的问题. 首先, 我们实现的功能就是在用户每次打开应用时, 都能去访问某一个资源, 并更新本地对应的数值. 同时为了避免发送的请求过多, 加入了一个 24 小时的限制. 实现上, 我们通过监听 `UIApplicationDidBecomeActiveNotification` 并将回调函数绑定到 `applicationDidBecomeActive:` 上, 理论上不存在多个 `applicationDidBecomeActive:` 函数同时执行的情况. 调查一路陷入了僵局.

但是碰巧的是, 正当我一筹莫展, 毫无思绪的档口, 出于闲着也是闲着的心态, 我开始了频繁开App, 按 Home 的操作. 然后突然间, 我在 Charles 上看到了并发的请求. 因为在之前的测试中, 我推测该情况出现在网络条件不好的情况下, 于是我将网速降低(通过中间 Proxy 限制了网速), 所以每一个 Request 的耗时基本都会在 2-3 秒. 也正是这 2-3 秒, 让我成功的复现了这个 Bug, 那接下来就是体力活了.

首先讲一下我们这个 App 中对网络请求的处理. 众所周知, 为了追求性能和响应速度, 我们倾向于将网络请求进行并发处理, 为了追求稳定和高效, 操作系统或者框架倾向于将网络请求并发数量降低到越少越好. 出于该情况下的 trade-off, 我们的 IOS 团队开发了一个 Action 框架. 核心思想就是通过一个生产着消费者模型来对网络请求进行处理. 每当要发送网络请求的时候, 我们会新建一个 action, 将其放到队列中, 然后注册好回调函数或者注册号触发的事件后离开.

我们之前的逻辑是:

```
applicationDidBecomeActive:
    createAction:
        if Now - lastActionTimestamp > 24h
            doNetworkRequest:
                Sucess: updateLastActionTimestamp:
                Failure: no op
```

可以看到因为将 24h 的 check 放到了 Action 里面, 所以会导致的一个情况就是如果队列中有多个 Action, 并且同时执行的时候, 该 Timestamp 并没有得到更新, 导致的情况就是该数个请求都会被同时执行. 同时, 因为 Action 框架中的任务队列不会随着 App 归于后台而消亡, 所以上一次新建的 Action 依旧会在队列中, 当下一次启动 App 的时候, 依旧会执行.

终于, 我们定位到了问题, 但怎么解决又成了新的问题.

#### 解决问题
一开始我们想的是, 要不要加一把锁, 将并行的请求变成串行. 但是这个问题的核心在于为什么创建了这么多的 Action. 所以最佳的解决办法就是把 24h 的 check 放到 createAction 之前. 

```
applicationDidBecomeActive:
    if Now - lastActionTimestamp > 24h
        createAction:
            doNetworkRequest:
                Sucess: updateLastActionTimestamp:
                Failure: no op
```

但这样还是无法解决 timestamp 不能及时更新的问题.

为了防止更多的任务被创建, 这是最高优先级要处理的问题. 我们把该逻辑修改如下:


```
applicationDidBecomeActive:
    if Now - lastActionTimestamp > 24h
        updateLastActionTimestamp:
        createAction:
            doNetworkRequest:
```


假设所有的 request 都能成功, 这样我们就能及时的更新 timestamp, 防止下一次请求依旧会创建 Action. 但问题来了, 如果请求失败了, 极端情况下我们就没办法在下一次的 App Active 时触发这个请求, 最后导致用户可能在 48h 中才会出现一次成功的 call.

所以我们继续改进这部分逻辑:

```
applicationDidBecomeActive:
    if Now - lastActionTimestamp > 24h
        updateLastActionTimestamp:
        createAction:
            doNetworkRequest:
                Sucess: no op
                Failure: revertLastActionTimestamp:
```

将 lastActionTimestamp 记录下来, 当请求失败的时候, revert 成为原有值, 这样的话既保证了紧接着的一次 App Active 不会创建新的 Action, 也能保证在用户请求失败之后, 接下来的几次 App Active 时能触发新的访问请求.

#### 最后的结果
当我们把代码提交, 等待 Deploy 的时候, 好奇问下了周围的几个同事, 问问有没有打开一个 App 然后快速 Home 的情况. 发现这好像是个共有习惯. 可能压力还是太大了吧. 后续的部署, 看 Log, 一切都按照预想的进行. 成功的将 8k 级别的错误压倒了个位数. 也算是成功解决了.

可能最后这部分的逻辑还有更加优化的空间, 并且这个框架也有不完善的地方, 但是这个解决方案也算是我们能想到的, 最快速, 最简单, 倾入性最小的方法了. 其实相比较于 Android 团队那边开发的 Sync 服务, IOS 团队还是出于刀耕火种的阶段, 并且在代码质量控制和测试上也是远远落后于其他团队. 可能这个 App 开发时间和任务量太大了吧. 总的看, 经过这次的和 IOS 团队的合作开发, 也算认识了很多有意思的人. 比如和团队分居地球两端的一个老哥, 一个人干着一个团队的活, 每隔两天就会提出一个几百文件改动的巨大 PR, 一个人完成了整个 App 的图形库开发. 也算是个人的楷模. 还有一个 25年+ 工作经验的 Senior, 在 Infra 上深耕多年, 每一行代码都熟悉异常.

