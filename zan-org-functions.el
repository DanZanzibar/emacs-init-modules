;; Start of zanf-org-refile-list-item and helpers
;; Lets you move a list item as-is to another heading within the same file.

(defvar zanv-org-refile-last-stored-list-item nil)

(defun zanf-org-refile-store-list-item ()
  (let ((beg (line-beginning-position))
        (end (line-end-position)))	
    (setq zanv-org-refile-last-stored-list-item (buffer-substring-no-properties beg end))
    (delete-region beg (line-beginning-position 2))))

(defun zanf-org-refile-choose-heading ()
  (completing-read "Choose a heading: "
		   (org-map-entries
		    #'(org-get-heading :no-tags :no-todo :no-cookie :no-comment))))

(defun zanf-org-refile-find-heading (target-heading)
  (goto-char (point-min))
  (re-search-forward (format "^\\*+\\( .*? \\| \\)%s" target-heading) nil nil 1)
  (goto-char (line-beginning-position))
  (unwind-protect
      (progn
	(org-narrow-to-subtree)
	(goto-char (point-max)))
    (widen)))

(defun zanf-org-refile-list-item ()
  (interactive)
  (let ((target (zanf-org-refile-choose-heading)))
    (zanf-org-refile-store-list-item)
    (zanf-org-refile-find-heading target)
    (insert "\n")
    (insert zanv-org-refile-last-stored-list-item)))

;; End of zanf-org-refile-list-item


(provide 'zan-org-functions)
