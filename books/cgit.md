
## 下载
https://git.zx2c4.com/cgit/refs/tags

### 安装
https://git.zx2c4.com/cgit/tree/README

### howoto

make get-git

make LUA_PKGCONFIG=lua5.1 或者 make NO_LUA=1

sudo make install


## 使用markdown

http://www.tuicool.com/articles/zmu63iQ

### 安装

http://jblevins.org/projects/markdown-mode/
下载 markdown-mode.el 至 emacs 的load path，并编辑.emacs增加以下内容，保证识别后缀名为text、markdown、md文件：
```
(autoload 'markdown-mode "markdown-mode"
    "Major mode for editing Markdown files" t)
    (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
    (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
```
### pandoc
markdown转换成html文件
sudo apt-get install pandoc

## 安装颜色

http://blog.csdn.net/a593796769/article/details/9000755

##
