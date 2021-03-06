为什么放弃 Hexo 而使用 Wordpress
---

最近看到一篇文章，主要讲的是自己为什么放弃使用 Wordpress 转而使用 Hexo。感触颇深，所以写这篇文章记录下我自己的想法。

### 为什么写博客
首先，为什么写博客，我已经忘记我开始写博客的原因了，可能是我大一的时候听说写博客在面试的时候加分？不过，现在投简历或者面试的时候我都尽量不再将博客写入简历中了。可能更想要的是一个安静的记录自己想法的地方吧。一开始自己想的是记录下觉得自己牛逼的事情放上来，比如帮学院刷票和破解学院的网关免费上网之类的。
但是这种事情又不会每周都有，于是开始记录下自己看书的内容。正好当时也去了实验室，实验室每周需要有周边，也就正好把周报当成博客进行编写了。不过，实习和工作之后，因为忙碌的原因，很长时间也没有开始写博，毕竟 995 之后，到家已经很晚，周末又只想休息。所以博客主要就变成了记录和发布自己新写的小工具，比如搞搞 VIM 插件之类的。总的来说，并没有把博客看成一个很功利的事情，而且经历了这么多年，用过的域名就不下 5 个，SEO 啥的，也就是压根没管，爱看不看吧。
说到换域名这个事情，感觉又是一篇博客，比如现在这个 D0n9X1n.dev 这个域名，这背后的 ID ，就又是一个故事了。

总结下，为什么写博，最贴切的一句话可能就是 **Just For Fun**。也没指望通过这个博客来找到工作，也不指望别人看了这个博客来系统学到知识，但是或许可以有新的想法？

### 为什么 Wordpress
在写博的这几年间，用过的，或者尝试使用过的博客系统有 Emlog、Wordpress、Hexo、Typecho、自研博客等等，其实和编辑器一样，很难找到一款满足自己所有小众需求的。何为小众需求呢，比如说博文的部分加密，这个需求来自于我维护的 **hexo-blog-encrypt** 插件。大体来说，博文的加密在我看来其实是小众需求，毕竟又要发布又要加密，其实是很矛盾的行为，如果要对这个行为做出合理解释，我能想到的就是付费或者满足他人的窥私欲。其中，部分加密在我看来就是为了付费而生的。为什么不做，很大程度是因为我比较厌恶凡事讲利益的做事风格。可能是比较理想的想法，毕竟我并没有打算从维护的几个插件中获得一分钱，也没有开通 Sponsor 功能，甚至可以的话，我希望我在网络上的 ID 可以和我现实生活割裂开来。扯回 Wordpress。关于小众需求，我自己就有一个，Github-Sync。这完全是一个历史遗留问题。在我开始写博的 2012 年，并没有一个很好的服务来同步自己的博客的服务，所以，我才用了写 markdown 并且保存在 github 上，然后通过 github 的渲染，将博客同步到对应的博客系统中，这样的好处有两个：
1. 可以保证博文的渲染是完全的 Github-Favorite Style。
2. 如果有图片等其他内容，还可以依赖 Github 的 CDN，减少服务器的带宽需求。

在当时看来，这个解决方案还是不错的。但是，放到现在来说，这就比较麻烦了，当时从 Emlog 迁移到 Wordpress，也是花了一个下午才写好的迁移脚本。如果是现在再进行迁移，可能代价就更大了。所以，因为懒，我现在也写了个同步 Github 的插件扔在 Wordpress 里面，方便我写博客。之所以没有使用 Hexo，里面一个很大的原因就是我熟悉 LAMP，而且基于 LAMP，我能做的事情大大高于 Hexo，也就是俗话说的自由度大，可以折腾。而且就生态而言，Wordpress 应该算最好的了。曾经喜欢用 Emlog，并成为开发者之一，但是论坛的氛围突然间就充满了付费做功能的气氛，感觉很无聊。而且受国内开发者风气的影响，Emlog 这个项目算是已经寿终正寝了。所以用 Wordpress 的原因总的来说有以下几个：
1. 方便进行魔改，功能强大
2. 维护团队饱经考验，不会突然失联
3. 生态完善，维护上节约时间

至于服务器费用问题，因为公司有 Azure 福利，所以也不是问题。

### 对 Hexo 的看法
大体来说，Hexo 是一个非常好的博客系统，特别适合于尝鲜的用户。或者说轻度用户，从项目的 issue 看，绝大部分的人最花心思的部分在美化博客上，也就是倒腾主题和插件，真正有 10 篇以上博客的人很少。对于这样一批人，Hexo 确实是完美的系统，开销也基本为 0，看看自己是否适合，而不是在写作之初就花几百大洋购买服务器域名等其他东西。也不是说 Hexo 不行，只是相比较于 Wordpress，Emlog 等传统博客系统，Hexo 在此的优势是最明显的。

最后总结一下，可能有些人会觉得 Hexo 比 Wordpress 好用，也有人会觉得 Wordpress 天下无敌，但是纯粹的踩抬是毫无意义的。只是希望大家能理性的看待，并且能维护好中文互联网环境吧。