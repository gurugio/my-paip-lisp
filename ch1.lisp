
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

(defparameter *titles*
  '(Mr Mrs Miss Ms Sir Madam Dr Admiral Major General))

(defun first-name (name)
  (if (member (first name) *titles*)
      (first-name (rest name))
      (first name)))

(mapcar #'first-name names)


(defun mappend (fn the-list)
  (apply #'append (mapcar fn the-list)))


(mappend #'(lambda (l) (list l (reverse l)))
	 '((1 2 3) (a b c)))


;; exercises 1.1
(defparameter *titles*
  '(Mr Mrs Miss Ms Sir Madam Dr Admiral Major General Jr. MD))

(defun before-last (the-list)
  (reverse (rest (reverse the-list))))

(defun last-name (name)
  (if (member (first (last name)) *titles*)
      (last-name (before-last name))
      (first (last name))))

(last-name '(Rex Morgan MD Jr.)) ; => Morgan


