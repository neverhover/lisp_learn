## 标准安装方法

http://www.jonathanfischer.net/modern-common-lisp-on-linux/

## 下载地址
www.sbcl.org

### 脚本运行
编写一个脚本如hello_world.lisp
```
#!/usr/bin/sbcl --script
(format t "Hello World")
```

###  使用clisp和slime

## 安装slime和运行clisp

请参考[http://www.cliki.net/slime-howto]

请添加以下代码到~/.emacs

```
(add-to-list 'load-path "/the/path/to/slime")
(require 'slime)
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;; Optionally, specify the lisp program you are using. Default is "lisp"
(setq inferior-lisp-program "yourlisp") 
```

## 运行slime

在启动emacs后，使用M-x slime来启动slime server"Swank".之后emacs会通过TCP自动连接到Lisp

如果想在emacs启动时，自动启动swank则需要加入以下配置
```
 (load "/path/to/swank-loader.lisp")
 (swank-loader:init)
```



## 加载文件

M-x slime-cd Enter然后输入路径，表示进入到该路径
然后在CL-USER中:
(load "xxx_lib.lisp")
执行完成后返回T

## 执行

参考[https://common-lisp.net/project/slime/doc/html/Evaluation.html#Evaluation]

C-c C-c 进行编译
C-x C-e 执行当前光标内容
C-M-x 或M-x slime-eval-defun来定义函数
C-c : 交互执行输入的指令
C-c C-r 先选定区域，然后执行该区域内的指令
C-c C-u Undefine光标指定的function


C-x o切换到inferior-lisp缓冲区中，进行测试
C-k 删除一行，不含换行
复制和粘贴:
C-2 然后移动光标，选中内容，然后M-w来进行复制
C-y 来进行粘贴
C-x k 来彻底关闭该缓冲区，并释放和缓冲区关联的文件

C-x { 当前窗口变窄
C-x } 当前窗口变宽
C-x + 所有窗口一样高
C-x z 重复执行上一个命令

## 编译可执行文件

参考[http://stackoverflow.com/questions/25046/lisp-executable]
在文件底部加入
```
(EXT:SAVEINITMEM "executable.exe"
                 :QUIET t
				 :INIT-FUNCTION 'main
				 :EXECUTABLE t
				 :NORC t)
```
where main is the name of the function you want to call when the program launches, :QUIET t suppresses the startup banner, and :EXECUTABLE t makes a native executable. 

```
(defun helloBlood ()
  "This is a function of helloBlood"
    (format t "OK OK!")
	  (EXT:EXIT))
	  
	  
(EXT:SAVEINITMEM "helloBlood.cl"
	:QUIET t
	:INIT-FUNCTION 'helloBlood
	:EXECUTABLE t
	:NORC t)
																		  
```
