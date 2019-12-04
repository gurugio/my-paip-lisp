;; M+x, M+e: (place cursor at the end of the expression) evaluate the expression and print the result at status window
;; C+c, C+c: compile the current expression
;; C+c, C+k: compile the current file

;; ex 3.1
(let* ((x 6)
       (y (* x x)))
  (+ x y))

((lambda (x)
   (+ x
      ((lambda (y) (* y y)) x))) 6)
  

(defun length1 (list)
  (let ((len 0))
    (dolist (element list)
      (incf len))
    len))


(defun length1.1 (list)
  (let ((len 0))
    (dolist (element list len)
      (incf len))))

(defun length2 (list)
  (let ((len 0))
    (mapc #'(lambda (element) (incf len)) list)
    len))

;; this does not work because-of "undefined variable: len" error.
;; (defun length3 (list)
;;   (do ((len 0) (+ len 1)
;;        (l list (rest l)))
;;       ((null l) len)))

;; does not work: count is an unknown keyword
;; (defun length4 (list)
;;   (loop for element list
;;      count t))

(defun true (x) t)
(defun length7 (list)
  (count-if #'true list))

(defun length8 (list)
  (if (null list)
      0
      (+ 1 (position-if #'true list :from-end t))))

(defun length9 (list)
  (if (null list)
      0
      (+ 1 (length9 (rest list)))))

(defun length10 (list)
  (length10-aux list 0))

(defun length10-aux (list len-so-far)
  (if (null list)
      len-so-far
      (length10-aux (rest list) (+ len-so-far 1))))
  
(defun length11 (list &optional (len-so-far 0))
  (if (null list)
      len-so-far
      (length11 (rest list) (+ len-so-far 1))))

(defmacro while (test &rest body)
  (list* 'loop
         (list 'unless test '(return nil))
         body))

(let ((i 7))
  (loop (unless (< i 10) (return nil))
     (print (* i i))
     (setf i (+ i 1 ))))

(let ((i 7))
  (while (< i 10)
    (print (* i i))
    (setf i (+ i 1))))
           
