如何在 Football Manager 2022 中使用真人照片
---

故事是这样的,因为公司福利的原因,我能够使用 XGP 计划进行游戏游玩,恰好关注的[ B 站 UP 主 - shhaady](https://space.bilibili.com/327185021?spm_id_from=333.337.search-card.all.click) 更新了 [Football Manager - 诺丁汉森林系列](https://space.bilibili.com/327185021/channel/collectiondetail?sid=38933),又恰好 XGP 计划中 Football Manager 也是计划之内. 所以理所当然的, 我也开始尝试起了这个游戏.没想到又是一个<文明>, <全面战争> 那样一个经典的时间杀手游戏.

游戏过程中, 最让我难受的一点是大部分球员是没有办法真人面孔的, 现有球员还能通过下载爱好者提供的人脸图像包进行修改, 但是对于系统自动生成的球员和职员来说, 那就是系统默认脸或者是通过 3D 建模生成的脸.

# 快速开始
## 准备工作,下载和解压必须的软件和资源
+ 首先可以前往 [Github - https://github.com/Maradonna90/NewGAN-Manager](https://github.com/Maradonna90/NewGAN-Manager) 进行下载一个 Python 程序
+ 同时下载对应的球员头像库: [newgan-facepack.1266](https://fm-base.co.uk/resources/newgan-facepack.1266/). 将 facepack 解压后，将 FMNEWGANv2 文件夹移动到以下位置：**%userprofile%\Documents\Sports Interactive\Football Manager 2022\graphics\faces**.
+ 如果缺少对应的文件夹,那么需要自己新建对应名字的文件夹, 并且在“graphics”文件夹中重复相同的过程以创建“faces”文件夹。
+ 下载 NewGAN-Manager-Installer-Win-vX.X.X.zip 并将其解压缩到一个文件夹中。
+ 从该文件夹中复制“filters”和“views”文件夹并将它们粘贴到以下文件夹中：%userprofile%\Documents\Sports Interactive\Football Manager 2021\
+ 返回解压后的安装程序文件夹，打开“windows”文件夹并运行 NewGAN-Manager-X.X.X.msi 并安装。

## 至此, 我们完成必要软件和配套资源的安装和保存. 然后就开始使用脚本进行球员和随机图片进行绑定.

+ 打开足球经理并加载您的存档,同时将语言设置成为英文,因为该脚本目前不支持除英文以外的语言.
+ 如果您没有游戏内编辑器，请创建一个新的失业经理来绕过您团队的球探知识。
+ 如果您有游戏内编辑器，请在球探选项卡中单击右上角的笔，并确保“显示搜索中的所有球员”旁边有一个复选标记。如果没有，请单击它，它将添加复选标记。
+ 点击“球探”（如果失业，点击“候选名单”），然后滚动到“球员”并点击“球员搜索”
+ 添加一个过滤器，以便在玩家搜索中只显示再生, 在“玩家搜索”窗口中点击“编辑搜索”，然后点击“清除”.  单击左下角的齿轮，然后单击“管理过滤器...”，然后单击“导入”.  选择“is newgen search filter”，然后点击“Load”，然后点击“Ok”.  再次点击左下角的齿轮，选择“is newgen search filter”.  如果出现要重命名的弹出窗口，请单击“否”.  通过单击“排除”并取消勾选“球员”，确保搜索不排除您球队的球员.

+ 添加过滤器后，您现在需要添加更改视图。单击“一般信息”下拉菜单，将鼠标悬停在“自定义”上，然后单击“导入视图...”，然后单击名为“SCRIPT FACES 玩家搜索”的视图。
+ 选择列表中的任何玩家，然后按 CTRL + A 选择列表中的所有玩家，这可能需要一分钟。选择所有玩家后，按 CTRL + P 将弹出一个弹出窗口，在此弹出窗口中选择“文本文件”并单击“确定”。现在给文件一个名字（最好是链接到你正在做的 FM 保存的东西）。此文件将保存在以下位置：**%userprofile%\Documents\Sports Interactive\Football Manager 2022**

## 自此, 我们完成了新建球员的数据导出, 接下来就是如何给他们创建随机头像.

+ 现在打开 NewGAN 管理器。
+ 通过为其命名来创建配置文件，然后单击“创建”，然后在下面的选项中选择配置文件。
+ 选择图像目录：**Documents\Sports Interactive\Football Manager 2022\graphics\faces\FMNEWGANv2/**
+ 通过导航到 **Documents\Sports Interactive\Football Manager 2022** 并选择之前保存的 RTF 文件。
+ 需要使用的模式是 "Generate", 如果你已经为新建球员运行过该程序,并希望保留当前的随即头像,那么可以选择 "Preverse" 模式
+ 单击“替换面孔”。

## 至此,我们已经为其创建了对应的随即头像, 同时你应该可以在游戏中进行预览.如果游戏中没有发现,那么需要进行清楚缓存.

+ 打开足球经理。单击“FM”，然后转到“首选项”。使用下拉选项并选择“接口”。向下滚动到皮肤部分并确保未选中“使用皮肤缓存以减少加载时间”，但确保选中“重新加载皮肤...”和“显示屏幕 ID...”。
+ 按确认并等待皮肤重新加载。
+ 然后就可以享受使用新面孔！

# 使用真人图像与 3D 建模之间的区别
简单的说,如果只是使用默认配置来进行游戏,那么你游戏中的梅西将是一个黑色的人物框, 非常没有带入感, 或者就是那些莫名其妙的 3D 建模头像, 非常的令人感觉生理不适.因为头像的原因, 我的存档很少有持续5年的,因为自己喜欢的球员退役之后,大部分的球员都变成了黑色默认头像或者是 3D 头像.在使用了这个工具之后,我终于带领着米德尔斯堡冲入了欧冠,并连冠!


# 该脚本的工作原理
其实,我们在导出球员信息的时候,其实附带了球员的地理信息.如果我们去查看 facepack 的文件结构,就能发现他的组织形式是 `洲\国家\地区` 这样的组织形式,通过这部分代码,脚本会将该球员洲\国家\地区的头像库中随机选择一个,并写入 XML 配置文件.

这部分代码我们可以在这里找到: [https://github.com/Maradonna90/NewGAN-Manager/blob/5a1bc3cdd24997a25080de60c308e2facc86cac3/src/newganmanager/app.py#L61](https://github.com/Maradonna90/NewGAN-Manager/blob/5a1bc3cdd24997a25080de60c308e2facc86cac3/src/newganmanager/app.py#L61), 如果未来能够支持不同语言,可能会更加方便吧.
