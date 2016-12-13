(defun range (start &optional end step)
  (unless end
    (setq end start
          start 0))
    (number-sequence start (1- end) step))

(defun countlist(list)
  (--count 'each? list))

(defun multipleof (n x)
  ;;
  (equal (mod x n) 0)
  )

(defun sumlist(list)
    (-sum list)
    )

(defun multipleof (n x)
  ;;
  (equal (mod x n) 0)
  )

(defun trip-or-quint-sum (limit)
  ;;
  (-sum (trip-or-quint limit))
 )

(defun trip-or-quint (limit)
  ;;
  (--filter (or (multipleof 5 it) (multipleof 3 it)) (range limit))
 )
