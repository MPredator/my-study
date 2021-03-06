Coding.net 作弊混码币
===

### 扯淡

无意之间发现了 Coding.net 这个代码托管网站，然后又发现了码币这个东西，居然是和实体货币可以交换的。于是就有了想法。

主要看看哪些选项是可以增加码币的，官方的说明如下：
> ![码币说明](https://dn-coding-net-production-pp.qbox.me/6413ee66-41f5-493e-8a53-971a003d252a.jpg)

有一点要注意下，就是邀请好友是0.02码币，不是说明中的0.01码币，并且确实存在这个100个上限。

当然这个码币也是挺诱人的，和人民币1:50的汇率。所以，接下来教大家如何刷这个东西

### 使用方法
点击 [求 star 的 cheat-coding.net 项目](https://github.com/MikeCoder/cheat-coding.net)， 目前只支持 \*uix 系统, 如 Mac, Ubuntu 等等。

1. 在一个空旷的目录下执行: **git clone https://github.com/MikeCoder/cheat-coding.net.git**
2. 执行 **cp config.py.example config.py**
3. 然后按照 config.py 中的提示，完成项目的配置
4. 最后执行 **sh guard.py**, 如果是希望一直在后台运行就执行: **nohup sh guard.py > logs/all.log**

顺利的话，这样就可以了。不过因为考虑到这个刷码币需要24小时不间断，所以，最好是能在服务器上进行部署。这样可以保证不会因为网络的问题，时常异常。虽然有处理，不过最好还是保持网络畅通。

### 注意地方
1. 目前只支持163企业邮箱。
2. 暂时不支持 Windows，不过应该可以用 MinGW 进行模拟，不过，没有进行测试


### 具体的思路
1. 代码的提交和任务的提交，都是很容易的。主要就是一个登陆的 post 和一个 git commit and git push 的定时任务。
2. 唯一比较麻烦的就是那个邀请好友加入。因为其他的几个除了一次性的加成，也只有这个能保证每天 0.1 码币的稳定收入。所以这个是重中之重。
    + 好在我有163企业邮箱，这个的好处就是可以免费申请很多很多的邮箱，而且不需要进行手机号码校验和验证码
    + 有了邮箱。我们就通过邀请链接输入用户的信息
    + 然后登陆新建的邮箱，找到那封验证邮件，然后访问那个验证链接
    + 这样，一个伪造的用户就这么诞生了，为了保证用户名的不同，我选了时间戳作为用户名
    + 当然，在新建邮箱的时候，163还会有一个防刷的保护，不过绕过也挺简单的
    + 通过上述的方法，就可以达到每天邀请5个用户加入 coding.net， 获得弥足珍贵的 0.1 码币
3. 最后就是重复的保证。那就用到了最简单暴力的解决办法。如下：

    ```
    #! /bin/sh

    while true
    do
        nohup python main.py > ./logs/all.log
    done
    ```

### 最后效果
> ![成果](http://chuantu.biz/t2/28/1456234433x1948221086.png)

### 最后
祝玩得开心
