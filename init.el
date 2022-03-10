(defconst dot-emacs (concat (getenv "HOME") "/.emacs.d/" "config.el")
  "My dot emacs file")

(require 'bytecomp)
(setq compiled-dot-emacs (byte-compile-dest-file dot-emacs))

(if (or (not (file-exists-p compiled-dot-emacs))
	(file-newer-than-file-p dot-emacs compiled-dot-emacs)
        (equal (nth 4 (file-attributes dot-emacs)) (list 0 0)))
    (load dot-emacs)
  (load compiled-dot-emacs))

(add-hook 'kill-emacs-hook
          '(lambda () (and (file-newer-than-file-p dot-emacs compiled-dot-emacs)
                           (byte-compile-file dot-emacs))))

(defun loadup-gen ()
  "Generate the lines to include in the lisp/loadup.el file
to place all of the libraries that are loaded by your InitFile
into the main dumped emacs"
  (interactive)
  (defun get-loads-from-*Messages* ()
    (save-excursion
      (let ((retval ()))
	(set-buffer "*Messages*")
	(beginning-of-buffer)
	(while (search-forward-regexp "^Loading " nil t)
	  (let ((start (point)))
	    (search-forward "...")
	    (backward-char 3)
	    (setq retval (cons (buffer-substring-no-properties start (point)) retval))))
	retval))))

(loadup-gen)

;; time the loading of the .emacs
;; keep this on top of your .emacs
(defvar *emacs-load-start* (current-time))
(defun anarcat/time-to-ms (time)
  (+ (* (+ (* (car time) (expt 2 16)) (car (cdr time))) 1000000) (car (cdr (cdr time)))))
(defun anarcat/display-timing ()
  (message ".emacs loaded in %fms" (/ (- (anarcat/time-to-ms (current-time)) (anarcat/time-to-ms *emacs-load-start*)) 1000000.0)))
(add-hook 'after-init-hook 'anarcat/display-timing t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(format-all-formatters '(("Java" astyle)) t)
 '(package-selected-packages
   '(lua-mode all-the-icons-dired rust-mode tide typescript-mode json-mode pyvenv saveplace-pdf-view pdf-tools vterm lsp-pyright python-mode tree-sitter-langs tree-sitter emmet-mode rainbow-delimiters format-all evil-nerd-commenter git-gutter forge magit counsel-projectile projectile company-box company dap-mode lsp-ivy lsp-ui treemacs-all-the-icons lsp-treemacs yasnippet-snippets yasnippet quickrun yafolding which-key visual-fill-column use-package org-mime org-bullets ivy-rich hl-todo helpful evil-tutor evil-collection emojify doom-themes doom-modeline dashboard counsel command-log-mode centaur-tabs)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
