;; is .gittable in the directory

(if (file-readable-p ".gittable")
    (message "init is here")
  ("Init is not here"))

;; Git add
(call-process "git add ." nil t)

;; Git commit
(call-process git commit -m "note")

;; Git push
(call-process "git push origin core")


*test
begbgb

gbgbgb

**test2
dfgngnn

***test3
dsfbsdfb
sdbsb
