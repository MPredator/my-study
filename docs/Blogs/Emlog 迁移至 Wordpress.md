Emlog 迁移至 Wordpress
---

作为一个 Emlog 4 年多的用户同时也是众多参与 Emlog 开发者中的一员，做出这个决定确实很难。不过，因为，Emlog 的长期荒废，同时论坛里高质量的内容越来越少。这个也是势在必行的趋势之一。

最后一根稻草是：混乱的社区。于是乎，最后转向了 Wordpress。

说道迁移，最麻烦的时数据的备份，之前也想过迁移，但是总是在最后一步卡住了，因为缺少一个合适的工具进行数据的导入导出。自己写的话，比较麻烦，因为对应的数据库表众多（其实就是懒）。

于是乎，这次我觉定自己玩一下。先是百度到了这么一篇文章：[emlog 5.3.1程序转入wordpress程序教程](https://www.1llo.cn/XinQi/325.html)。得到了这么一个优秀的脚本 em2wp.php。

但是跑了一下，发现问题挺大的。因为这个版本的 php 是用 5 来写的，现在所有的云主机，基本都是 7 打底，所以就会有兼容性问题:

+ Wordpress 版本更新之后，对应的表结构发生了改变。
+ PHP7 以后不再支持 mysql_xxxx 函数。
+ 代码并不会显示错误代码。
+ 中文字符集的乱码问题。

于是自己修改了下，并且运行成功。代码 [GIST - em2wp.php](https://gist.github.com/MikeCoder/c5c247186b1264851135d891fc10522e)。

代码不会修改 emlog 原始表结构，所以放心的在线上执行，毕竟如果是迁移，Wordpress 的库内容是无足轻重的。并且，我相信各位都是可以成功看到 GIST 的。

不过总体而言，迁移非常的成功。剩下的 https，资源文件，域名，postId 保持一致，则都是体力活了。

本来以为一切都已经搞定了，可是，我去 google 搜了一下我的博客，发现他的 url 为 `https://mikecoder.cn/post/{postId}`，然后看看其他人引用我博客的时候的 url 则是 `https://mikecoder.cn/?post={postId}`。

不管是哪一种，WP 都没有默认的支持，前者比较好办，直接在后台进行修改就好，修改默认的链接为 `/post/%postId%/` 即可，后者则是比较麻烦。因为不太想修改 Wordpress 的源码（不太清楚有多少地方需要修改）。想了一会，最后确定添加 NGINX 重写规则的方案（还好会一点 NGINX）。

添加注释中的代码即可。将 `?post=(\d+)` 的请求全都重定向到 WP 识别的请求上。

```
    error_page 404 = https://mikecoder.cn/404;
    # ==================================
    if ($args ~* post=(\d+)) {
        set $args '';
        set $id $1;
        rewrite ^ http://mikecoder.cn/?p=$id;
    }
    # ==================================
    root /home/wp/wordpress;
    index index.html index.htm index.php;
    location / {
        try_files $uri $uri/ /index.php?$query_string;
        index index.php;
    }
```

至此，基本上所有的配置已经完成。现在的主要任务又变成了，如何快速的了解 Wordpress 的代码结构。同时争取成为 Wordpress 的开发者。

最后感慨下，Wordpress 确实是做的最完善的一个博客系统。

#### 为什么不用 hexo

1. 作为一个稍微会一点 php 的人，还是想自己能魔改整个系统的。
2. 作为一个 hexo 的插件开发者，我也知道 hexo 用来写博客的局限性。不是很愿意被限制。
3. 我正好买了 3 年的云主机，不用也是浪费啊。
4. 大量的数据不太好使用静态博客迁移。

#### 为什么不用 typecho

1. 其实和 emlog 一样的问题。WP 能满足所有的功能，且大部分做的更加完善。所以没理由使用 EM 和 TY（追求简单除外）。
2. 论坛活跃度不如 WP，想获得新的主题或者插件，都比较困难。
3. EM 和 TY 的活跃用户仅限于国内。接轨世界的话，WP 确实是最好的选择。

最后的最后，感谢 EMLOG 的开发者。
