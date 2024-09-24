;; name project r16cwc
;; name program r
;; name extension newlisp
;; name describer cwc
;; name data 16
;; name unit 16

(slice (now) 0 3)                        ; year month day using explicit slice
(0 3 (now))                              ; year month day using implicit slice
(select (now) '(0 1 2))                 ; year month day using selection
(3 3 (now))                              ; hour minute second
(nth 8 (now))                           ; day of the week, starting from Sunday 

;; date used on its own will give you the current date and time for the local time zone (now
;; and date-value return values in UCT/UTC, not relative to your local time zone):

(date)
;-> "Mon Mar 19 20:05:02 2006"

;; It can also tell you the date of an integer number of seconds since 1970 (the start of the
;; Unix epoch), adjusted for your local time zone:

(date 0)

;-> "Wed Dec 31 16:00:00 1969"

(date 0)
;-> "Thu Jan 1 01:00:00 1970"
; a US newLISP user sees this
; a European newLISP user sees this
;; date-value can calculate the number of seconds for a speciﬁc date or date/time (in UT):

(date-value 2024 09 23)
;-> 1147305600; just the date

(date-value 2024 09 23 23 59 59)
;-> 1147391999

;; Because date-value can accept the year, month, day, hours, minutes, and seconds as input,
;; it can be applied to the output of now:

(apply date-value (now))
;-> 1164723787

;; By converting diﬀerent times to these date values, you can do calculations. For example,
;; to subtract November 13 2003 from January 3 2005:

(- (date-value 2024 09 23) (date-value 2024 09 23))
;-> 36028800
; seconds, which is
(/ 36028800 (* 24 60 60))
;-> 417
; this is a duration in days - don't convert this to a date!

;; You can ﬁnd out the date that is 12 days after Christmas Day 2005 by adding 12 days-worth
;; of seconds to the date:

(+ (date-value 2024 09 23) (* 12 24 60 60))
; seconds in 12 days
;-> 1136505600
; this is an instant in time, so it can be converted!


;; This seconds value can be converted to a human-friendly date by date in its longer form,
;; when it takes a seconds-since-1970 value and converts it to a local time zone representation
;; of this UT-based value:

;; Of course (date (date-value)) is the same as (date), but you'll have to use the longer form if
;; you want to change the date format. date accepts an additional formatting string (preceded
;; by a time-zone oﬀset in minutes). If you're familiar with C-style strftime formatting, you'll
;; know what to do:

(date (date-value) 0 "%Y-%m-%d %H:%M:%S")
;-> 2006-06-08 11:55:08
; ISO 8601

(date 1136505600 0 "%Y-%m-%d %H:%M:%S")
;-> "2006-01-06 00:00:00"

(date (date-value) 0 "%Y%m%d-%H%M%S")
;-> "20061207-144445"
; in London

(date (date-value) (* -8 60) "%Y%m%d-%H%M%S") ; in Los Angeles
;-> "20061207-064445"
; 8 hours offset

;; 10.2.1 Reading dates and times: parse-date
;; The parse-date function (which is, unfortunately, not available on Windows) can convert
;; date and time strings to seconds-since-1970 values. You supply a date-time format string
;; after the string:

(parse-date "2024-09-23" "%Y-%m-%d")
;-> 1165968000

(date (parse-date "2024-09-23 20:12" "%Y-%m-%d %H:%M"))
;-> "Thu Feb 8 20:12:00 2007"


;; 10.3 Timing and timers
;; For timing purposes, you can use these functions:
;; • time return the time taken to evaluate an expression, in milliseconds
;; • timer set a timer to wait for a certain number of seconds and then evaluate expression
;; • sleep stop working for a certain number of milliseconds
;; time is useful for ﬁnding out how much time expressions take to evaluate:

(time (read-file "/home/admin/ProjectEmacs/ik5pwq/matrix/gnu/bin/dk0lwl.lisp"))

;; You can supply a repetition count as well, which probably gives a more accurate picture:

(time (for (x 1 1000) (factor x)) 100)

;-> 426
; 100 repetitions

;; If you can't or don't want to enclose expressions, more simple timing can be done using
;; time-of-day:


;-> 27
; milliseconds

;; timer is basically an alarm clock. Set it and then forget about it until the time comes. You
;; supply a symbol specifying the alarm action, followed by the number of seconds to wait:

(define (teas-brewed)
          (println (date) " Your tea has brewed, sir!"))
(timer teas-brewed (* 3 60))


