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


