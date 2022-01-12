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

(setq message-log-max t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lsp-java yasnippet-snippets yafolding which-key vterm visual-fill-column use-package typescript-mode treemacs-all-the-icons tree-sitter-langs rust-mode rainbow-delimiters quickrun org-bullets no-littering lsp-ui lsp-ivy ivy-rich hl-todo helpful helm-lsp forge flycheck evil-tutor evil-nerd-commenter eterm-256color emojify emmet-mode dracula-theme doom-themes doom-modeline dired-single dired-open dashboard dap-mode counsel-projectile company-box command-log-mode centaur-tabs auto-package-update all-the-icons-dired)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
