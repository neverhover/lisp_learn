第三章内容：函数定义

以下为的打印你的名字
(defun print_name (name)
  "Print your name and say Hello to you"
  (message "Hello %s" name))

(print_name "blood")
---------------------------------------
版本2,加上注释
(defun print_name2 (name) ;这是一行注释
  "print_name的版本2,带有注释"
  (message "Hello %s in print_name2" name))
---------------------------------------
版本3,交互函数
(defun print_name3 (name)
  "print you name.version 3"
  (mesage "Hello %s in print_name3"))
