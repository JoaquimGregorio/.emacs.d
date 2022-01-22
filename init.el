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
 '(custom-safe-themes
   '("234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" "82ef0ab46e2e421c4bcbc891b9d80d98d090d9a43ae76eb6f199da6a0ce6a348" "c4063322b5011829f7fdd7509979b5823e8eea2abf1fe5572ec4b7af1dd78519" "9b4ae6aa7581d529e20e5e503208316c5ef4c7005be49fdb06e5d07160b67adc" "9f218080c0526490543e9ce0dc539c092b1777872930d96a0585cf11caaff842" "cf922a7a5c514fad79c483048257c5d8f242b21987af0db813d3f0b138dfaf53" default))
 '(org-babel-load-languages '((emacs-lisp . t) (python . t) (C . t)))
 '(package-selected-packages
   '(visual-fill-column lsp-java go-complete go-mode doom-themes dired yasnippet-snippets yafolding which-key vterm use-package treemacs-all-the-icons tree-sitter-langs tide rust-mode rainbow-delimiters quickrun python-mode org-bullets lsp-ui lsp-pyright lsp-ivy lorem-ipsum json-mode ivy-rich hl-todo helpful git-gutter format-all forge evil-tutor evil-nerd-commenter evil-collection emojify emmet-mode doom-modeline dired-single dired-open dashboard dap-mode counsel-projectile company-box command-log-mode centaur-tabs all-the-icons-ivy all-the-icons-dired)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
