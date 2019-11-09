;; M+x, M+e: (place cursor at the end of the expression) evaluate the expression and print the result at status window
;; C+c, C+c: compile the current expression
;; C+c, C+k: compile the current file

;; ch2.2
(defun sentence () (append (noun-phrase) (verb-phrase)))
(defun noun-phrase () (append (Article) (Noun)))
(defun verb-phrase () (append (Verb) (noun-phrase)))
(defun Article () (one-of '(the a)))
(defun Noun () (one-of '(man ball woman table)))
(defun Verb () (one-of '(hit took saw liked)))

(defun one-of (set)
  (list (random-elt set)))

(defun random-elt (choices)
  (elt choices (random (length choices))))
	   
(sentence)

;; ch2.3

(defparameter *simple-grammar*
  '((sentence -> (noun-phrase verb-phrase))
	(noun-phrase -> (Article Noun))
	(verb-phrase -> (Verb noun-phrase))
	(Article -> the a)
	(Noun -> man ball woman table)
	(Verb -> hit took saw liked))
  "A grammar for a trivial subset of English")


