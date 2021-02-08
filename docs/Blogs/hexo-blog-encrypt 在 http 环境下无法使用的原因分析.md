hexo-blog-encrypt 在 http 环境下无法使用的原因分析
---

###背景
hexo-blog-encrypt 是一个用来加密 hexo 博文的插件, 其核心的技术点就是在 hexo 渲染时将原文进行 AES 加密, 然后在展示的时候使用密码进行解密. 从原理上看, 并不会存在 http 无法使用而 https 可以使用的限制. 但是, 最近有很多的 issue 都指向了这个奇怪的现象, 以下是几个典型的 issues:

+ [issue 129 - https://github.com/D0n9X1n/hexo-blog-encrypt/issues/129](https://github.com/D0n9X1n/hexo-blog-encrypt/issues/129)
+ [issue 128 - https://github.com/D0n9X1n/hexo-blog-encrypt/issues/128](https://github.com/D0n9X1n/hexo-blog-encrypt/issues/128)
+ [issue 114 - https://github.com/D0n9X1n/hexo-blog-encrypt/issues/114](https://github.com/D0n9X1n/hexo-blog-encrypt/issues/114)
+ [issue 166 - https://github.com/D0n9X1n/hexo-blog-encrypt/issues/166](https://github.com/D0n9X1n/hexo-blog-encrypt/issues/166)
+ ...

以至于在 #166 中, 有人提出了继续支持 http 的建议. 当然, 本着让互联网更安全的愿景, 在 http 上我是不会让步的.

###调查
一开始有人爆出这个问题的时候,他的博客是属于 http/https 混用的,理所当然的, 我就简单的把问题锁定在 Chrome 不再支持加载 http/https 混合资源的原因上. 但是, 后来有人又爆出来,全 http 的网站也同样无法使用, 而且还很神奇的是火狐可行, Chrome 失败.(这里还是可以看出火狐简直业界清流).于是在网友的帮助下,我们找到了如下的几段分析:

```

大概率是因为 Chrome 已经开始阻止页面加载 http 资源.
英文版新闻: Google Chrome Will Block Mixed Content
中文版新闻: Chrome 将不再允许 https:// 页面加载 HTTP 资源

    @D0n9X1n 作者你好, 很感谢你的插件, 写的很好, 也感谢维护和回答提问. 不过关于这个大家频繁反馈的报错问题
    我觉得您的推测可能不是很对. 有以下几个原因, 我也自己亲测验证了一下:
    1.  首先就是 Chrome 只是默认禁止了 https 的页面加载 http 资源, 但是并没有限制 http 页面加载 http/https 资源.
        否则无数内网/或者早些的网站都没法访问了.
    2.  其次 Chrome 的这个规则, 其实也不是直接禁止了 http 资源, 它实际做的是, 先强制把所有 http 资源尝试用 https 访问
        , 如果访问失败, 会明确在控制台提示加载https资源不存在, 然后退化后的http资源再默认禁止, 而且这个选项可以通过网
        站设置修改, (但是在当前报错下没有效果, 看起来并不是一个问题)
    3.  我在网页是 http 的前提下, 尝试手动修改了页面加载 encrpt.js 的地址为 https://xxx/lib/encrpt.js (文件存在).
        发现仍然提示同样的错误. 然后本地加载成功, 实际访问的也是 http://xxx/lib/encrpt.js,
        看起来并非简单的取决于js文件是否加载为 http/https 资源
    看起来要寻找问题根本原因, 从本机部署时可以访问, 但 http 页面 + http/https 的js文件不能访问, 全https才可访问去看可能更好查找.
    虽然看起来最后把站点切换为 https 解决了问题, 但是这看上去像是歪打正着的感觉, 有些原因网站无法https化的情况,
    或者内网ip部署的情况下, 还是希望有人能提供一个解决方案, 或者有一个可供 http 使用的版本来兼容使用.
    再次感谢作者的付出, 也希望给其他希望搞清根本原因的同学一点参考

        这个是浏览器自带的功能, 不需要任何外部加载, 唯一的原因就是 This feature is available only in secure contexts (HTTPS).
        而 localhost 能正常解密的原因是, localhost 加载的相当于是本地界面, 对于浏览器来说是无条件信任的
```

可以看到,网友还是非常的给力, 瞬间定位到了问题的本质.具体可以看 [Stack Overflow - 这个问题回答](https://stackoverflow.com/questions/46468104/how-to-use-subtlecrypto-in-chrome-window-crypto-subtle-is-undefined).

### 原因
其根本原因就是 Chrome 在设计之时, 就指定了加密部分的API接口只允许在安全链接下进行:
> Access to the WebCrypto API is restricted to secure origins (**which is to say https:// pages**).
>
> Note: In the spec, crypto.subtle is supposed to be undefined in insecure contexts, whereas in Chrome it is defined however any operation on it fails with NotSupportedError. (*This will be updated in the future*).

所以对应的解决办法就是申请免费的 SSL 证书, 然后上传到服务器中, 或者直接使用 Github Pages 的强制 https 功能.

### 最后
再次感谢网友, 也许正是这样一帮刨根问底的朋友在, 我才能保持一个积极的态度持续的进行更新. 虽然也不是一个很好的插件, 虽然功能也很羸弱, 甚至都不是我的本职工作方向...

人人为我,我为人人.
