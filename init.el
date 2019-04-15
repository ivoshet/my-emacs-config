;; System-type definition

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defun system-is-linux()
  (string-equal system-type "gnu/linux"))
(defun system-is-windows()
  (string-equal system-type "windows-nt"))

(add-to-list 'load-path "~/.emacs.d/lisp")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;FOR MELPA AND INSTALLATION PACKAGES

(load "package")
(require 'package)
(setq package-archives '(

("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq inhibit-splash-screen   t)
(setq ingibit-startup-message t) ;; экран приветствия можно вызвать комбинацией C-h C-a

;;нумерация строк
;; Linum plugin
(require 'linum) ;; вызвать Linum
(line-number-mode   t) ;; show line number in mode-line
(global-linum-mode  t) ;; показывать номера строк во всех буферах
(column-number-mode t) ;; показать номер столбца в mode-line
(setq linum-format " %d") ;; задаем формат нумерации строк

;; Coding-system settings
(set-language-environment 'UTF-8)
(if (system-is-linux) ;; для GNU/Linux кодировка utf-8, для MS Windows - windows-1251
    (progn
      (setq default-buffer-file-coding-system 'utf-8)
      (setq-default coding-system-for-read    'utf-8)
      (setq file-name-coding-system           'utf-8)
      (set-selection-coding-system            'utf-8)
      (set-keyboard-coding-system        'utf-8-unix)
      (set-terminal-coding-system             'utf-8)
      (prefer-coding-system                   'utf-8))
  (progn
    (prefer-coding-system                   'windows-1251)
    (set-terminal-coding-system             'windows-1251)
    (set-keyboard-coding-system        'windows-1251-unix)
    (set-selection-coding-system            'windows-1251)
    (setq file-name-coding-system           'windows-1251)
    (setq-default coding-system-for-read    'windows-1251)
    (setq default-buffer-file-coding-system 'windows-1251)))

;; Пишем название открытого буфера в шапке окна
(setq frame-title-format "GNU Emacs: %b")

;; АВТОЗАКРЫТИЕ!!!!!!!!!!!!!!!
(electric-pair-mode    1) ;; автозакрытие {},[],() с переводом курсора внутрь скобок
;;(electric-indent-mode -1) ;; отключить индентацию  electric-indent-mod'ом (default in Emacs-24.4)
(setq electric-pair-pairs '(
			    (?\" . ?\")
			    (?\{ . ?\})
			    (?\'.?\')

			    )) 

;; Delete selection
(delete-selection-mode t)

;;внешний вид

(tooltip-mode      -1)
(menu-bar-mode     -1) ;; отключаем графическое меню
(tool-bar-mode     -1) ;; отключаем tool-bar
(scroll-bar-mode   -1) ;; отключаем полосу прокрутки
(setq use-dialog-box     nil) ;; никаких графических диалогов и окон - все через минибуфер
(setq redisplay-dont-pause t)  ;; лучшая отрисовка буфера
(setq ring-bell-function 'ignore) ;; отключить звуковой сигнал
;; Display file size/time in mode-line
(setq display-time-24hr-format t) ;; 24-часовой временной формат в mode-line
(display-time-mode             t) ;; показывать часы в mode-line
(size-indication-mode          t) ;; размер файла в %-ах

;;настройка фона
(set-background-color "gray10") 
;;настройка шрифта 
(set-foreground-color "white")
;;цвет курсора
(set-cursor-color "green")
;;шрифт 
(set-default-font "monospace-9") 
(add-to-list 'default-frame-alist '(font . "monospace-9"))

;; Disable backup/autosave files
(setq make-backup-files        nil)
(setq auto-save-default        nil)
(setq auto-save-list-file-name nil) ;; я так привык... хотите включить - замените nil на t

;; Определим размер окна с Emacs при запуске
(when (window-system)
  (set-frame-size (selected-frame) 400 50))

;; Indent settings
;;(global-set-key (kbd "RET") 'newline-and-indent) ;; при нажатии Enter перевести каретку и сделать отступ

;; отменить автопереносы длинных строк
(setq word-wrap          nil) ;; переносить по словам
(global-visual-line-mode nil)


;; Short messages
(defalias 'yes-or-no-p 'y-or-n-p)

;;подсветка парных скобок
(show-paren-mode t) 

(setq default-cursor-type 'bar )

(require 'sgml-mode)


;;(add-to-list 'load-path "/home/ivo/.emacs.d/elpa/fill-column-indicator")
;;(require 'fill-column-indicator)

;;WEB-MODE

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
;;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;;disabel underlining in react native files
(setq js2-strict-missing-semi-warning nil)
;;(setq js2-mode-show-parse-errors nil)
;;(setq js2-mode-show-strict-warnings nil)

;;(require 'yaml-mode)
;;    (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))


;;show indent
(indent-guide-global-mode)
(setq highlight-indent-guides-method 'character)

(setq web-mode-enable-current-element-highlight t)


(defun web-mode-element-close-and-indent ()
  (interactive)
  (web-mode-element-close)
  (indent-for-tab-command))

(define-key web-mode-map (kbd "C-c /") 'web-mode-element-close-and-indent)

(setq web-mode-auto-close-style 2)
(setq web-mode-tag-auto-close-style 2)

;;fill column indicator
(add-to-list 'load-path "/home/ivo/.emacs.d/elpa/fill-column-indicator-1.90")
(require 'fill-column-indicator)
(setq fci-rule-width 1)
(setq fci-rule-color "red")
(setq fci-rule-column 80)
(fci-mode 1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-args-compile (quote ("-c" "--no-header" "--bare")))
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
    ("5f27195e3f4b85ac50c1e2fac080f0dd6535440891c54fcfa62cdcefedf56b1b" default)))
 '(package-selected-packages
   (quote
    (flymake-hlint neotree editorconfig monokai-theme rainbow-identifiers eslint-fix js2-mode jsx-mode typescript-mode python-mode format-all django-mode django-theme indent-guide coffee-mode rainbow-mode dired-sidebar project-explorer fill-column-indicator web-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)
;;monokai
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/monokai-theme-3.5.3/")
;; (setq monokai-theme-kit t)
;; (load-theme 'monokai t)
;;M-x load-theme RET monokai

;;neotree
(add-to-list 'load-path "/home/ivo/.emacs.d/elpa/neotree-0.5.2")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-window-fixed-size nil)
(setq neo-window-width 45)
(add-hook 'after-init-hook #'neotree-toggle)
(setq neo-autorefresh nil)


