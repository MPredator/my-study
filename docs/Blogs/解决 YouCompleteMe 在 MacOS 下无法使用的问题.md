解决 YouCompleteMe 在 MacOS 下无法使用的问题
---

简单的说一下问题, YouCompleteMe 应该是目前 vim 下比较好的代码补全插件, 但是最近遇到的一个问题. 当系统更新到最新的版本时, YCM 无法正常使用了. 第一反应立马就是查看 Github Issue, 果然看到了一个类似的问题:

### 问题描述
可以参考该 [GitHub Issue: https://github.com/ycm-core/YouCompleteMe/issues/3877](https://github.com/ycm-core/YouCompleteMe/issues/3877)

简单的说就是当打开正常的 Cpp 文件时, YCM 会提示出现各种异常, 而这些异常通常为库文件错误:

> ![Error vim](https://user-images.githubusercontent.com/18110408/116440133-21726e00-a88b-11eb-9648-d7397f0d0718.png)

而在系统升级之前, YCM 都是可以正常工作的.

### 解决办法
0. 确认使用了 brew 版本的 vim, python3 进行开发, 可以通过 `brew install vim python3` 来进行安装.
1. 确认是否自己安装了 llvm, 可以通过 `brew install llvm` 进行确认.
2. 将 llvm 的路径加入 path, 以 zsh 为例, 需要在 `.zshrc` 中加入 `export PATH="/usr/local/opt/llvm/bin:$PATH"`.
3. 确认 vim 使用了 brew 版本的 clang, 可以通过 `which clang` 来进行确认. 一定要为 `/usr/local/opt/llvm/bin/clang`.
4. 编译 YouCompleteMe, 通过脚本 `python3 install.py --clangd-completer`.
5. 在 `.vimrc` 中加入 `let g:ycm_clangd_binary_path='clangd'`.
6. 正常使用.

### 查找问题
其实这个问题也是很简单, 只怪自己没有在 brew install 的时候多留意系统日志输出:

```
$ brew link llvm
Warning: Refusing to link macOS provided/shadowed software: llvm
If you need to have llvm first in your PATH, run:
  echo 'export PATH="/usr/local/opt/llvm/bin:$PATH"' >> ~/.zshrc

For compilers to find llvm you may need to set:
  export LDFLAGS="-L/usr/local/opt/llvm/lib"
  export CPPFLAGS="-I/usr/local/opt/llvm/include"
```

可以看到 brew link 下面的第一行, macOS 已经拒绝 link llvm 作为默认的 C/C++ 编译器, 而这一行输出在之前的系统版本中是不存在的. 所以解决办法就是手动在配置文件中指定优先选择的编译器.

知道原因了之后就很简单, 但是当时着实让自己头疼了一段时间, 因为 vim 是我的主力刷题编辑器, 而在刷题中, 最重要的就是手速, YCM 在效率上给我带来了很大的提升, 甚至有很多组合键已经形成了习惯. 在没有 YCM 的那一天里, 刷题突然就速度慢了下来...

当时也留意了 github issue 中的解决办法, 但是依旧是没有成功, 好在自己留意了日志, 才发现了线索. 不得不吐槽下苹果, 自从 xcode 自签名就无法登录之后, 再也无法在 xcode 中使用上 vim 的键位配置了... 感觉他在封闭的路上越走越远了. 还有以后不知道会不会全换 MX 芯片之后, 又会带来如何的兼容性噩梦...
