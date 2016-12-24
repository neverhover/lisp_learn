;;定义CD， :来作为属性名
(list :a 1 :b 2 :c 3)

;;定义函数,返回list
(defun make-cd (title artist rating ripped)
  "定义MAKE-CD函数"
  (list :title title :artist artist :rating rating :ripped ripped))
;;创建一条记录
(make-cd "张学友2016" "Jay" 7 t)

;;创建变量来保存数据
(defvar *db* nil)
;;创建一个函数来添加记录
(defun add-record (cd)
  "添加一条记录到DB中"
  (push cd *db*))

;;来，插入一条试试，先是生成cd，然后插入到db中
(add-record (make-cd "My bad" "JackSon" 8 t))
;;来，插入一条试试，先是生成cd,然后插入到db
(add-record (make-cd "相约1998" "JackSon" 8 t))

;;输出db内容
(defun dump-db ()
  (dolist (cd *db*)
    (format t "~{~a: ~10t~a~%~}~%" cd))) ;;~是类似%，指令以她开始;~%则是换行;~a是美化;{}则是表示消耗循环
;;----------------------------------------------------
;;交互
(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))
;;交互输入
(defun prompt-for-cd ()
  (make-cd
   (prompt-read "Title")
   (prompt-read "Artist")
   (prompt-read "Rating")
   (prompt-read "Ripped [y/n]")))
;;下一步Rating和Ripped应该是数字和bool类型，那么要如何做呢？
;; 解析成数字
(or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
;; 修改Y-N提示
(y-or-n-p "Ripped [y/n]: ")
;;好，重新定义prompt-for-cd
(defun prompt-for-cd ()
  "新定义的版本cd输入"
  (make-cd
  (prompt-read "标题")
  (prompt-read "作者")
  (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
  (y-or-n-p "Ripped [y/n]")))

;;现在可以重复输入来插入数据到db中了
(defun add-cds ()
  "重复交互插入CD到DB中"
  (loop (add-record (prompt-for-cd))
     (if (not (y-or-n-p "继续输入? [y/n]: ")) (return 1))))
;;------------------------------分割线----------------------
;;现在得把内存的东西放到文件中了
(defun save-db (filename)
  "把内存CD数据库存入到文件中去"
  (with-open-file (out filename :direction :output
		       :if-exists :supersede)
    (with-standard-io-syntax
      (print *db* out ))))

;;现在读取数据库文件
(defun load-db (filename)
  "读取数据库文件"
  (with-open-file (in filename)
    (with-standard-io-syntax (setf *db* (read in)))))
;; -----------------------------分割线-----------------------
;;有了读取和保存，那么就需要查询，更新等操作方法

;;取得所有偶数,注意是从内存中加载list并copy了一份到新的list后进行操作
(remove-if-not #'evenp '(1 2 3 4 5 6 7 8 9 10))

;;#'是"获取函数，其名称如下"，如果不加上，则会变成一个变量名
;;#'evenp是谓词
;;替代#'evenp,判断x mod 2以后是否等于0
;;lambda是一个匿名函数
(lambda (x) (= 0 (mod x 2)))

;;现在在一条记录中找到某个字段等于某个值的,我们想一步到位，显然是有问题的
(defun select-row (colname colval)
  "在list中查找某一行中某列的值等于某个值的记录"
  (remove-if-not
   (lambda (cd)
     (equal (getf cd colname) colval))
   *db*))

;;selector-artist，以下是一个闭包的用法
(defun artist-select (artname)
  #'(lambda (cd) (equal (getf cd :artist) artname)))

;;select
(defun select (select-fn)
  (remove-if-not
   select-fn *db*))

;;(select (artist-select "JackSon"))则可以查询artist的内容

;;我们想要的是类似where的东西,需要用到形参
;;(select (where :artist "123" :ripped nil))
(defun where (&key title artist rating (ripped nil ripped-p))
  "查询多个条件"
  #'(lambda (cd)
      (and
       (if title (equal (getf cd :title) title) t)
       (if artist (equal (getf cd :artist) artist) t)
       (if rating (equal (getf cd :rating) rating) t)
       (if ripped-p (equal (getf cd :ripped) ripped) t))))

;;update操作
(defun update (selector-fn  &key title artist rating (ripped nil ripped-p))
  "更新CD记录操作"
  (setf *db*
	(mapcar
	 #'(lambda (cd)
	     (when (funcall selector-fn cd)
       (if title (setf (getf cd :title) title) )
       (if artist (setf (getf cd :artist) artist) )
       (if rating (setf (getf cd :rating) rating) )
       (if ripped-p (setf (getf cd :ripped) ripped) ))
	     cd) *db*)))

;;delete操作

;; --------------------------------分割线-------------------------
(defmacro)
