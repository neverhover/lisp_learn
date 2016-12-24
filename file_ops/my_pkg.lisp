;;;;; Packages

(defpackage :org.timewing.pkg_lib
  (:use :common-lisp)
  (:export :hi))

;;;; 进入package
(in-package :org.timewing.pkg_lib)

(defun hi (name)
  "Hi name"
  (format t "~a~%" name))
;;;; 定义一个package并且导入之前定义的pakage
(defpackage :org.timewing.pkg_tool
  (:use
   :common-lisp
   :org.timewing.pkg_lib))

