;;;; This is file io examples

;; Read a file
(defun read-aline (filename)
  "Read a line form filename"
  (let ((fin (open filename)))
    (format t "~a~%" (read-line fin))
    (close fin)))

(read-aline "/opt/lisp/lisp/ch1.el")


(defun read-file (filename)
  "Read all lines form filename"
  (let ((fin (open filename :if-does-not-exist nil)))
    (when fin
      (loop for line = (read-line fin nil)
	 while line do
	   (format t "~a~%" line))
      (close fin))))


(read-file "/opt/lisp/lisp/ch1.el")
