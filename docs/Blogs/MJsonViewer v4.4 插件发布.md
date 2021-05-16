MJsonViewer v4.4 版本中使用到的 JS 复制操作
---

之前自己写的这个插件还是挺满意的, 不过最近遇到一个不太方便的地方, 就是当查看完 JSON 数据之后, 如果想把数据复制下来, 直接 ctrl+a 和 ctrl+c 之后, 就会有很多乱七八糟的 tag. 所以写了这个版本的功能.

这个功能主要作用就是当检测到数据为 JSON 时, 将数据复制到系统的剪贴板上. 功能非常简单, 但是当实现这个功能时发现一个比较好玩的事情, 就是通过 JS 接口, 调用系统剪切板.

### Document.execCommand 方式
简单的说, 要想将数据复制到剪贴板中, 一共分为两步:

1. 获取需要复制的数据, 一般我们可以通过 document.getElement().innerHtml 来获得, 当然前提条件是还没有进行 JSON 解析和修饰.
2. 调用系统接口, 将获取到的数据放入系统剪贴板中.

按照 MSDN 的文档, 我们可以通过浏览器扩展和系统交互的方式, 得到如下的一个代码段:

```
document.execCommand("copy")
document.execCommand("cut")
document.execCommand("paste")
```

简单的说, 我们需要显式的调用 select() 函数, 来标明需要被复制的内容, 然后通过 execCommand("copy") 的方式来进行复制, 一个简单的例子就是:

```js
function copy() {
  var copyText = document.querySelector("#input");
  copyText.select();
  document.execCommand("Copy");
}

// Add to a button
document.querySelector("#copy").addEventListener("click", copy);
```

但是这样的过程可能会出现一个权限问题, 比如在火狐中就会出现:

```
"document.execCommand('cut'/'copy') was denied because it was not called from inside a short running user-generated event handler."
```

所以需要在插件的 manifest 中加入 clipboard 的新权限.

### 异步 Clipboard API
这就是除了上述方法的一个备选方案, 但是他也需要同时在 manifest 文件中申请 clipboardRead 与 clipboardWrite 权限. 在插件中, 也可以使用如下的代码段来进行保护:

```
navigator.permissions.query({name: "clipboard-write"}).then(result => {
  if (result.state == "granted" || result.state == "prompt") {
    /* write to the clipboard now */
  }
});

```

完成权限的检查后, 就可以使用这个函数使用一个字符串作为输入并且用它更新剪贴板:

```
function updateClipboard(newClip) {
  navigator.clipboard.writeText(newClip).then(function() {
    /* clipboard successfully set */
  }, function() {
    /* clipboard write failed */
  });
}
```

相比之下, 更加灵活, 同时在对大型内容的复制上不会卡住主线程, 降低 UI 的可用性.

### 总结
以上就是两种 JS 调用系统剪贴板的方式, 但是众所周知在前端的世界里, 一定会有多浏览器兼容性问题. 这里也不例外, 比如 Firefox 只有在 54 及以后版本中提供了 "clipboardRead" permission ，但是仅支持向处于内容可编辑模式的元素粘贴，对于内容脚本，只能在 `<textarea>` 工作。对于后台脚本，任何元素都可被设置为内容可编辑模式。

所以, 本来以为就一行代码的事情, 没想到反而还让自己测试了半天. 还好只是一个简单的功能, 前端真的是有点麻烦.

