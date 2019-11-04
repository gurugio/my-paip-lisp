
;; M+x, M+e: (place cursor at the end of the expression) evaluate the expression and print the result at status window
;; C+c, C+c: compile the current expression
;; C+c, C+k: compile the current file

(defparameter names '((John Q Public) (Malcolm X)
              (Admiral Grace Murray Hopper) (Spot) 
              (Aristotle) (A A Milne) (Z Z Top)
              (Sir Larry Olivier) (Miss Scarlet)))

(defun first-name (name)
  (first name))

(defun last-name (name)
  (first (last name)))

(last-name names)

(mapcar #'+ '(1 2 3 4) '(10 20 30 40))
