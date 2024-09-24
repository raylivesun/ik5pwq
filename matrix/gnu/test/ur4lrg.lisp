;; name project ur4lrg
;; name program ur
;; name extension newlisp
;; name describer lrg
;; name data 4
;; name unit 4

;; 9.13.1 Functions available for arrays
;; The following general-purpose functions work equally well on arrays and lists: ﬁrst, last,
;; rest, mat, nth, setf, sort, append, and slice.
;; There are also some special functions for arrays and lists that provide matrix operations:
;; invert, det, multiply, transpose. See Matrices3 .
;; Arrays can be multi-dimensional. For example, to create a 2 by 2 table, ﬁlled with 0s,
;; use this:

(set 'arry (array 2 2 '(0)))
;-> ((0 0) (0 0))


;; The third argument to array supplies some initial values that newLISP will use to ﬁll the
;; array. newLISP uses the value as eﬀectively as it can. So, for example, you can supply a
;; more than suﬃcient initializing expression:

(set 'arry (array 2 2 (sequence 0 10)))
arry
;-> ((0 1) (2 3))

;; or just provide a hint or two:
(set 'arry (array 2 2 (list 1 2)))
arry
;-> ((1 2) (1 2))
(set 'arry (array 2 2 '(42)))
arry
;-> ((42 42) (42 42))

;; This array initialization facility is cool, so I sometimes use it even when I'm creating lists:

(set 'maze (array-list (array 10 10 (randomize (sequence 0 10)))))

;-> ((9 4 0 2 10 6 7 1 8 5)
;-> (3 9 4 0 2 10 6 7 1 8)
;-> (5 3 9 4 0 2 10 6 7 1)
;-> (8 5 3 9 4 0 2 10 6 7)
;-> (1 8 5 3 9 4 0 2 10 6)
;-> (7 1 8 5 3 9 4 0 2 10)
;-> (6 7 1 8 5 3 9 4 0 2)
;-> (10 6 7 1 8 5 3 9 4 0)
;-> (2 10 6 7 1 8 5 3 9 4)
;-> (0 2 10 6 7 1 8 5 3 9))


;; 9.14 Getting and setting values
;; To get values from an array, use the nth function, which expects a list of indices for the
;; dimensions of the array, followed by the name of the array:

(set 'size 10)
(set 'table (array size size (sequence 0 (pow size))))


(dotimes (row size)
(dotimes (column size)
           (print (format {%3d} (nth (list row column) table))))
; end of row
(println))


;; (nth also works with lists and strings.)
;; As with lists, you can use implicit addressing to get values:

(set 'size 10)
(set 'table (array size size (sequence 0 (pow size))))
(table 3)
;-> (30 31 32 33 34 35 36 37 38 39)
(table 3 3)
;-> 33
; row 3 (0-based!)
; row 3 column 3 implicitly

;; To set values, use setf. The following code replaces every number that isn't prime with 0.

(set 'size 10)
(set 'table (array size size (sequence 0 (pow size))))
(dotimes (row size)
(dotimes (column size)
(if (not (= 1 (length (factor (nth (list row column) table)))))
(setf (table row column) 0))))
table

;; Instead of the implicit addressing (table row column), I could have written (setf (nth (list
;; row column) table) 0). Implicit addressing is slightly faster, but using nth can make code
;; easier to read sometimes.

;; 9.15 Matrices
;; There are functions that treat an array or a list (with the correct structure) as a matrix.

;; • invert returns the inversion of a matrix
;; • det calculates the determinant
;; • multiply multiplies two matrices
;; • mat applies a function to two matrices or to a matrix and a number
;; • transpose returns the transposition of a matrix
;; transpose is also useful when used on nested lists (see Association lists4 ).


;; 9.16 Statistics, ﬁnancial, and modelling functions
;; newLISP has an extensive set of functions for ﬁnancial and statistical analysis, and for
;; simulation modelling.
;; Given a list of numbers, the stats function returns the number of values, the mean, average
;; deviation from mean value, standard deviation (population estimate), variance (population
;; estimate), skew of distribution, and kurtosis of distribution:

(set 'data (sequence 1 10))
;->(1 2 3 4 5 6 7 8 9 10)
(stats data)
(10 5.5 2.5 3.02765035409749 9.16666666666667 0 -1.56163636363636)

;; Here's a list of other functions built in:
;;• beta calculate the beta function
;; • betai calculate the incomplete beta function
;; • binomial calculate the binomial function
;; • corr calculate the Pearson product-moment correlation coeﬃcient
;; • crit-chi2 calculate the Chi square for a given probability
;; • crit-f calculate the critical minimum F for a given conﬁdence probability
;; • crit-t calculate the critical minimum Student's t for a given conﬁdence probability
;; • crit-z calculate the critical normal distributed Z value of a given cumulated probability
;; • erf calculate the error function of a number
;; • gammai calculate the incomplete gamma function
;; • gammaln calculate the log gamma function
;; • kmeans-query calculate the Euclidian distances from the data vector to centroids
;; • kmeans-train perform Kmeans cluster analysis on matrix-data
;; • normal produce a list of normal distributed ﬂoating point numbers
;; • prob-chi2 calculate the cumulated probability of a Chi square
;; • prob-f ﬁnd the probability of an observed statistic
;; • prob-t ﬁnd the probability of normal distributed value
;; • prob-z calculate the cumulated probability of a Z value
;; • stats ﬁnd statistical values of central tendency and distribution moments of values
;; • t-test use student's t-test to compare the mean value


;; 9.17 Bayesian analysis
;; Statistical methods developed initially by Reverend Thomas Bayes in the 18th century
;; have proved versatile and popular enough to enter the programming languages of today. In
;; newLISP, two functions, bayes-train and bayes-query, work together to provide an easy
;; way to calculate Bayesian probabilities for datasets.
;; Here's how to use the two functions to predict the likelihood that a short piece of text is
;; written by one of two authors.
;; First, choose texts from the two authors, and generate datasets for each. I've chosen Oscar
;; Wilde and Conan Doyle.

(set 'doyle-data
     (parse (lower-case
     (read-file "/home/admin/ProjectEmacs/ik5pwq/matrix/gnu/bin/oz4z.lisp")) {\W} 0))

(set 'wilde-data
    (parse (lower-case
    (read-file "/home/admin/ProjectEmacs/ik5pwq/matrix/gnu/bin/oz4z.lisp")) {\W} 0))

;; The bayes-train function can now scan these two data sets and store the word frequencies
;; in a new context, which I'm calling Lexicon:

(bayes-train doyle-data wilde-data 'Lexicon)

;; This context now contains a list of words that occur in the lists, and the frequencies of each.
;; For example:
;; Lexicon:_always
;-> (21 110)

;; ie the word always appeared 21 times in Conan Doyle's text, and 110 times in Wilde's.
;; Next, the Lexicon context can be saved in a ﬁle:

(save "/home/admin/ProjectEmacs/ik5pwq/matrix/gnu/bin/dk0lwl.lisp" 'Lexicon)

;; and reloaded whenever necessary with:

