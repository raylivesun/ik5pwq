;; name project om3sem
;; name program om
;; name extension newlisp
;; name describer sem
;; name data 3
;; name unit 3

;; and reloaded whenever necessary with:

(load "/home/admin/ProjectEmacs/ik5pwq/matrix/gnu/bin/dk0lwl.lisp")

;; With training completed, you can use the bayes-query function to look up a list of words
;; in a context, and return two numbers, the probabilities of the words belonging to the ﬁrst

;; or second set of words. Here are three queries. Remember that the ﬁrst set was Doyle, the
;; second was Wilde:

(set 'quote1
     (bayes-query
     (parse (lower-case
     "the latest vegetable alkaloid" ) {\W} 0)
     'Lexicon))
;-> (0.973352412 0.02664758802)

(set 'quote2
     (bayes-query
     (parse
     (lower-case
     "observations of threadbare morality to listen to" ) {\W} 0)
     'Lexicon))
;-> (0.5 0.5)

(set 'quote3
     (bayes-query
     (parse
     (lower-case
     "after breakfast he flung himself down on a divan
     and lit a cigarette" ){\W} 0)
     'Lexicon))
;-> (0.01961482169 0.9803851783)


;; These numbers suggest that quote1 is probably (97% certain) from Conan Doyle, that quote2
;; is neither Doylean nor Wildean, and that quote3 is likely to be from Oscar Wilde.
;; Perhaps that was lucky, but it's a good result. The ﬁrst quote is from Doyle's A Study in
;; Scarlet, and the third is from Wilde's Lord Arthur Savile's Crime, both texts that were
;; not included in the training process but - apparently - typical of the author's vocabulary.
;; The second quote is from Jane Austen, and the methods developed by the Reverend are
;; unable to assign it to either of the authors.


;; 9.18 Financial functions
;; newLISP oﬀers the following ﬁnancial functions:
;; • fv returns the future value of an investment
;; • irr returns the internal rate of return
;; • nper returns the number of periods for an investment
;; • npv returns the net present value of an investment
;; • pmt returns the payment for a loan
;; • pv returns the present value of an investment

;; 9.19 Logic programming
;; The programming language Prolog made popular a type of logic programming called uni-
;; ﬁcation. newLISP provides a unify function that can carry out uniﬁcation, by matching
;; expressions.

(set 'x 5)
(set 'y 5)

(unify '(+ x y) '((+ 1 2) (- (* 4 5))))
         (+ (+ x (+ 1 2)) (+ y (- (+ 4 5))))

;; When using unify, unbound variables start with an uppercase character to distinguish them
;; from symbols.

;; 9.20 Bit operators
;; The bit operators treat numbers as if they consist of 1's and 0's. We'll use a utility function
;; that prints out numbers in binary format using the bits function:

(define (binary n)
          (if (< n 0)
          ; use string format for negative numbers
          (println (format "%6d %064s" n (bits n)))

; else, use decimal format to be able to prefix with zeros
(println (format "%6d %064d" n (int (bits n))))))

;; This function prints out both the original number and a binary representation of it:

(binary 6)
;->  6 0000000000000000000000000000000000000000000000000000000000000110
;-> "6 0000000000000000000000000000000000000000000000000000000000000110"


;; This function prints out both the original number and a binary representation of it:
(binary 6)
;->6 0000000000000000000000000000000000000000000000000000000000000110
;-> "6 0000000000000000000000000000000000000000000000000000000000000110"
;; The shift functions (<< and >>) move the bits to the right or left:
(binary (<< 6)) ; shift left
;-> 12 0000000000000000000000000000000000000000000000000000000000001100
;->"12 0000000000000000000000000000000000000000000000000000000000001100"
(binary (>> 6)) ; shift right
;-> 3 0000000000000000000000000000000000000000000000000000000000000011
;->"3 0000000000000000000000000000000000000000000000000000000000000011"
;; The following operators compare the bits of two or more numbers. Using 4 and 5 as
;; examples:
(map binary '(5 4))
;-> 5 0000000000000000000000000000000000000000000000000000000000000101
;-> 4 0000000000000000000000000000000000000000000000000000000000000100
;-> ("5 0000000000000000000000000000000000000000000000000000000000000101"
;-> "4 0000000000000000000000000000000000000000000000000000000000000100")
(binary (^ 4 5)) ; exclusive or: 1 if only 1 of the two bits is 1
;-> 1 0000000000000000000000000000000000000000000000000000000000000001
;-> "1 0000000000000000000000000000000000000000000000000000000000000001"

(binary (| 4 5)) ; or: 1 if either or both bits are 1
;->5 0000000000000000000000000000000000000000000000000000000000000101
;->"5 0000000000000000000000000000000000000000000000000000000000000101"
(binary (& 4 5)) ; and: 1 only if both are 1
;->4 0000000000000000000000000000000000000000000000000000000000000100
;->"4 0000000000000000000000000000000000000000000000000000000000000100"
;; The negate or not function (˜) reverses all the bits in a number, exchanging 1's and 0's:
(binary (~ 5)) ; not: 1 <-> 0
;-> -6 1111111111111111111111111111111111111111111111111111111111111010
;->"-6 1111111111111111111111111111111111111111111111111111111111111010"
