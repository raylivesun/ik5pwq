;; name project i2htt
;; name program i
;; name extension newlisp
;; name describer htt
;; name data 2
;; name unit 2

;; 11.2 Reading and writing data
;; newLISP has a good selection of input and output functions.
;; An easy way of writing text to a ﬁle is append-ﬁle, which adds a string to the end of a
;; ﬁle. The ﬁle is created if it doesn't exist. It's very useful for creating log ﬁles and ﬁles that
;; you write to periodically:

(dotimes (x 10)
     (append-file "/home/admin/ProjectEmacs/ik5pwq/matrix/gnu/bin/dk0lwl.lisp"
     (string (date) " logging " x "\n")))

;; and there's now a ﬁle on my desktop with the following contents:

;; You don't have to worry about opening and closing the ﬁle.
;; To load the contents of a ﬁle into a symbol in one gulp, use read-ﬁle.

(set 'contents (read-file "/home/admin/ProjectEmacs/ik5pwq/matrix/gnu/bin/dk0lwl.lisp"))
;-> ";; init.lsp - newLISP initialization file\n;; gets loaded automatically on
; ...

;; The symbol contents stores the ﬁle's contents as a single string.
;; open returns a value which acts as a reference or 'handle' to a ﬁle. You'll probably want
;; to use the ﬁle later, so store the reference in a symbol:

(set 'data-file (open "newfile.data" "read"))
; in current directory
; and later


;; Use read-line to read a ﬁle one line at a time from a ﬁle handle. Each time you use
;; read-line, the next line is stored in a buﬀer which you can access with the current-line
;; function. The basic approach for reading a ﬁle is like this:

;; read-line discards the line feed at the end of each line. println adds one at the end of the
;; text you supply. For more about argument handling and main-args, see STDIO2 .
;; For small to medium-size ﬁles, reading a source ﬁle line by line is much slower than loading
;; the whole ﬁle into memory at once. For example, the source document for this book is
;; about 6000 lines of text, or about 350KBytes. It's about 10 times faster to process the ﬁle
;; using read-ﬁle and parse, like this:




