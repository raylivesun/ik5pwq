#|
oz4z:
- Author: admin
- Date: 2024-09-23
|#

;; 9.12 Trigonometry
;; All newLISP's trigonometry functions, sin, cos, tan, asin, acos, atan, atan2, and the
;; hyperbolic functions sinh, cosh, and tanh, work in radians. If you prefer to work in
;; degrees, you can deﬁne alternative versions as functions:
(constant 'PI 3.141592653589793)
(define (rad->deg r)
(mul r (div 180 PI)))
(define (deg->rad d)
(mul d (div PI 180)))
(define (sind _e)
(sin (deg->rad (eval _e))))
(define (cosd _e)
(cos (deg->rad (eval _e))))