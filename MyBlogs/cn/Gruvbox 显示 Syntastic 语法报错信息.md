Gruvbox 显示 Syntastic 语法报错信息
---

Vim 的 Gruvbox 配色方案现在取代了我使用了两年的 Solarized，因为他的分辨率更胜一筹。所以，我决定了后者开始了退役。但是，遇到一个问题，因为 Syntastic 语法检测的时候，他和我现在使用的代码自动格式化插件有冲突。

在格式化之后，他的错误前标(sign)会出现在错误的位置。所以，为了更方便的查找错误，我一般是开语法错误高亮的。就像如下的效果：

> ![solarized](https://user-images.githubusercontent.com/3142935/35227571-6bc1242e-ffc9-11e7-89cb-059c02c94072.png)

但是在使用了 Gruvbox 之后，会出现这样的情况：

> ![Gruvbox](https://user-images.githubusercontent.com/3142935/35227579-6f5190ce-ffc9-11e7-864e-586d3b7544f4.png)

这个就很诡异了。他并没有给出对应的语法错误高亮。然后我又更换了几个其他主题，比如 desert，tomorrow 等，发现这个只是在 Gruvbox 上才会出现，所以我去他的 github 上提了这么个 [issue](https://github.com/morhetz/gruvbox/issues/222) 但是，并么有及时的得到回复。

所以，只好自己动手丰衣足食，在比对了 solarized 和 gruvbox 的代码之后，终于发现了端夷。

原来在语法配色中，有 SyntasticError 和 SyntasticWarning 这两个，而在 gruvbox/color/gruvbox.vim 中，它是如下的描述：

```
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign GruvboxRedSign
hi! link SyntasticWarningSign GruvboxYellowSign

" }}}
```

所以，理所当然的，它并不能很好的显示出对应的语法错误。只需要修改成如下就好了:

```
" Syntastic: {{{

call s:HL('SyntasticError', s:red, s:none, s:underline, s:red)
call s:HL('SyntasticWarning', s:red, s:none, s:underline, s:red)

hi! link SyntasticErrorSign GruvboxRedSign
hi! link SyntasticWarningSign GruvboxYellowSign

" }}}
```

对应的修改之后的效果如下：

> ![Gruvbox](https://user-images.githubusercontent.com/3142935/35253876-9ce49d2a-0022-11e8-9673-bcaaaad776f1.png)

感觉不错。
