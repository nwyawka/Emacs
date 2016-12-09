(defun cheap-count-words ()
  (interactive)
  (let ((words 0))
    (save-excursion
      (goto-char (point-min))
      (while (forward-word)
        (setq words (1+ words))))
    (message (format "words: %s" words))
    words))


(require 'ert)

(ert-deftest count-words-test ()
  (get-buffer-create "*test*")
  (with-current-buffer "*test*"
    (erase-buffer)
    (insert "Hell World")
    (should (= (cheap-count-words) 2))
    )
  (kill-buffer "*test*"))
