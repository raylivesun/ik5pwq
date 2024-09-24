;; name project w4eze
;; name program w
;; name extension eze
;; name describer eze
;; name data 4
;; name unit 4

;; 9.21 Bigger numbers
;; For most applications, integer calculations in newLISP involve whole numbers up to
;; 9223372036854775807 or down to -9223372036854775808. These are the largest integers
;; you can store using 64 bits. If you add 1 to the largest 64-bit integer, you'll 'roll over' (or
;; wrap round) to the negative end of the range:

(set 'large-int 9223372036854775807)
(+ large-int 1)
;-> -9223372036854775808

;; But newLISP can handle much bigger integers than this, the so-called 'bignums' or 'big
;; integers'.

(set 'number-of-atoms-in-the-universe 100000000000000000000000000000000000000000000000000000000000000000000000000000000)
;-> 100000000000000000000000000000000000000000000000000000000000000000000000000000000L
(++ number-of-atoms-in-the-universe)
;-> 100000000000000000000000000000000000000000000000000000000000000000000000000000001L
(length number-of-atoms-in-the-universe)
;-> 81
(float number-of-atoms-in-the-universe)
;->1e+80

;; Notice that newLISP indicates a big integer using a trailing "L". Usually, you can do
;; calculations with big integers without any thought:

(* 100000000000000000000000000000000 100000000000000000000000000000)
;-> 10000000000000000000000000000000000000000000000000000000000000L

;; Here both operands are big integers, so the answer is automatically big as well.
;; However, you need to take more care when your calculations combine big integers with other
;; types of number. The rule is that the ﬁrst argument of a calculation determines whether
;; to use big integers. Compare this loop:

(for (i 1 10) (println (+ 9223372036854775800 i)))


;; In the ﬁrst example, the ﬁrst argument of the function was a large (64-bit integer). So
;; adding 1 to the largest possible 64 bit integer caused a roll-over - the calculation stayed in
;; the large integer realm.
;; In the second example, the L appended to the ﬁrst argument of the addition forced newLISP
;; to switch to big integer operations even though both the operands were 64 bit integers. The
;; size of the ﬁrst argument determines the size of the result.
;; If you supply a literal big integer, you don't have to append the "L", since it's obvious that
;; the number is a big integer:

(for (i 1 10) (println (+ 92233720368547758123421231455634 i)))


;; There are other ways you can control the way newLISP converts between large and big
;; integers. For example, you can convert something to a big integer using the bigint function:

(set 'bignum (bigint 9223372036854775807))

(* bignum bignum)
;-> 85070591730234615847396907784232501249L

(set 'atoms (bigint 1E+80))
;-> 100000000000000000000000000000000000000000000000000000000000000000000000000000000L

(++ atoms)
;-> 100000000000000000000000000000000000000000000000000000000000000000000000000000001L

;; 10 Working with dates and times
;; 10.1 Date and time functions

;; To work with dates and times, use the following functions:
;; • date convert a seconds count to a date/time, or return date/time for now
;; • date-value return the time in seconds since 1970-1-1 for a date and time, or for now
;; • now return the current date/time information in a list
;; • time-of-day return milliseconds since the start of today till now
;; date-value and now work in UT, not your local time. date can take account of the time
;; diﬀerence between your local time and UT.


;; 10.2 The current time and date
;; All four functions can be used to return information about the current time. date-value
;; returns the number of seconds between 1970 and the current time (in UT):

1142798985

;; and now returns a list of integers containing information about the current date and time
;; (in UT):

(now)
;-> (2006 3 19 20 5 2 125475 78 1 0 0)

;; This provides the following information:
;; • year, month, day (2006, 3, 19)
;; • hour, minute, second, microsecond (20, 5, 2, 125475)
;; • day of current year (78)
;; • day of current week (1)
;; • local time zone oﬀset (in minutes west of GMT) (0)
;; • daylight savings time ﬂag (0)
;; To extract the information you want, use a slice or pick out the elements:

(slice (now) 0 3)                   ; year month day using explicit slice
(0 3 (now))                         ; year month day using implicit slice
(select (now) '(0 1 2))            ; year month day using selection
(3 3 (now))                         ; hour minute second 
(nth 8 (now))                      ; day of the week, starting from Sunday





