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

(defvar *grammar* *simple-grammar*
  "The grammar used by generate.")

(assoc 'Noun *grammar*)

(defun rule-lhs (rule)
  "left-hand side of rule"
  (first rule))

(defun rule-rhs (rule)
  (rest (rest rule)))

(defun rewrites (category)
  (rule-rhs (assoc category *grammar*)))

(defun random-elt (choices)
  (elt choices (random (length choices))))

(defun mappend (fn the-list)
  (apply #'append (mapcar fn the-list)))

(defun generate (phrase)
  "Generate a random sentence"
  (cond ((listp phrase) (mappend #'generate phrase))
	((rewrites phrase) (generate (random-elt (rewrites phrase))))
	(t (list phrase))))

(defun generate (phrase)
  (if (listp phrase) (mappend #'generate phrase)
	  (let ((choices (rewrites phrase)))
		(if (null choices) (list phrase)
			(generate (random-elt choices))))))



;; ex 2.1
(defun generate (phrase)
  (let ((choices (rewrites phrase)))
	(cond ((listp phrase) (mappend #'generate phrase))
	      (choices (generate (random-elt choices)))
	      (t (list phrase)))))


;; ex 2.2
(defun term-sym (phrase)
  (not (assoc phrase *grammar*)))

(defun generate-2.2 (phrase)
  "Generate a random sentence"

  (cond ((listp phrase) (mappend #'generate-2.2 phrase))
        ((rewrites phrase) (generate-2.2 (random-elt (rewrites phrase))))
        ((term-sym phrase) (list phrase))))

;; 2.5
(defparameter *bigger-grammar*
  '((sentence -> (noun-phrase verb-phrase))
    (noun-phrase -> (Article Adj* Noun PP*) (Name) (Pronoun))
    (verb-phrase -> (Verb noun-phrase PP*))
    (PP* -> () (PP PP*))
    (Adj* -> () (Adj Adj*))
    (PP -> (Prep noun-phrase))
    (Prep -> to in by with on)
    (Adj -> big little blue green adiabatic)
    (Article -> the a)
    (Name -> Pat Kim Lee Terry Robin)
    (Noun -> man ball woman table)
    (Verb -> hit took saw liked)
    (Pronoun -> he she it these those that)))

(setf *grammar* *bigger-grammar*)

;; 2.6
(defun generate (phrase)
  "Generate a random sentence"
  (cond ((listp phrase) (mappend #'generate phrase))
        ((rewrites phrase) (generate (random-elt (rewrites phrase))))
        (t (list phrase))))

(defun generate-tree (phrase)
  (cond ((listp phrase) (mapcar #'generate-tree phrase))
        ((rewrites phrase)
         (cons phrase (generate-tree (random-elt (rewrites phrase)))))
        (t (list phrase))))

;; ex 2.4
(defun cross-product (x ylist)
  (if (not ylist)
      nil
      (cons (list x (first ylist))
            (cross-product x (rest ylist)))))

(defun combine-all (xlist ylist)
  (if (not xlist)
      nil
      (append (apply #'cross-product (first xlist) (list ylist)) ;why list?
            (combine-all (rest xlist) ylist))))
