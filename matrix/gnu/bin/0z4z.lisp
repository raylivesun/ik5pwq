;; name project oz4z
;; name program oz
;; name extension  newlisp
;; name describer z
;; name data 4
;; name unit 4

;; 9.12 Trigonometry
;; All newLISP's trigonometry functions, sin, cos, tan, asin, acos, atan, atan2, and the
;; hyperbolic functions sinh, cosh, and tanh, work in radians. If you prefer to work in
;; degrees, you can deﬁne alternative versions as functions:

(constant 'PI 3141592653589793)

(define (rad->deg r)
          (mul r (div 180 PI)))

(define (deg->rad d)
          (mul d (div PI 180)))

(define (sind _e)
          (sin (deg->rad (eval _e))))

(define (cosd _e)
          (cos (deg->rad (eval _e))))

(define (tand _e)
         (tan (deg->rad (eval _e))))

(define (asind _e)
         (rad->deg (asin (eval _e))))

(define (atan2d _e _f)
         (rad->deg (atan2 (deg->rad (eval _e)) (deg->rad (eval _f)))))

;; When writing equations, one approach is to build them up from the end ﬁrst. For example,
;; to convert an equation like this:
;; {
;; α = arctan
;; sin λ cos ϵ−tan β sin ϵ
;; cos λ
;; }
;; build it up in stages, like this:

;; and so on...
;; It's often useful to line up the various expressions in your text editor:

(set 'right-ascension
      (atan2d
           (sub
               (mul
               (sind lamda)
               (cosd epsilon))
     (mul
          (tand beta)
          (sind epsilon)))
          (cosd lamda)))
          
;; If you have to convert a lot of mathematical expressions from inﬁx to postﬁx notation, you
;; might want to investigate the inﬁx.lsp module (available from the newLISP website):

;; 9.13 Arrays
;; newLISP provides multidimensional arrays. Arrays are very similar to lists, and you can
;; use most of the functions that operate on lists on arrays too.

;; A large array can be faster than a list of similar size. The following code uses the time
;; function to compare how fast arrays and lists work.

(for (size 712 96000000)
      ; create an array
     (set 'arry (array size (randomize (sequence 0 size))))
     ; create a list
     (set 'lst (randomize (sequence 0 size)))
     (set 'array-time
                (time (dotimes (x (/ size 2))
     (nth x arry)) 100))
     ; repeat at least 100 times to get non-zero time!
     (set 'list-time
           (time (dotimes (x (/ size 2))
           (nth x lst)) 50))
     (println "with " size " elements: array access: "
     array-time
     "; list access: "
     list-time
      " "
(div list-time array-time )))

;; The exact times will vary from machine to machine, but typically, with 200 elements, arrays
;; and lists are comparable in speed. As the sizes of the list and array increase, the execution
;; time of the nth accessor function increases. By the time the list and array contain 1000
;; elements each, the array is 2 to 3 times faster to access than the list.
;; To create an array, use the array function. You can make a new empty array, make a new
;; one and ﬁll it with default values, or make a new array that's an exact copy of an existing
;; list.

(set 'table (array 10))                             ; new empty array
(set 'lst (randomize (sequence 0 20)))         ; new full list 
(set 'arry (array (length lst) lst))               ; new array copy of a list


;; To make a new list that's a copy of an existing array, use the array-list function:
(set 'lst2 (array-list arry)) ; makes new list


;; To tell the diﬀerence between lists and arrays, you can use the list? and array? tests:
(array? arry)
;-> true
(list? lst)
;-> true




