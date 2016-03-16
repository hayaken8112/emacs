(defvar user-emacs-directory "~/.emacs.d/")
(global-set-key "\M-g" 'goto-line) ;指定の行に移る
;;load-pathを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;;引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")
;;テーマ設定
(when (require 'color-theme nil t)
  (color-theme-initialize)
  (color-theme-pok-wob))
;;文字コード指定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
;;タイトルバーにファイルのフルパス表示
(setq frame-title-format "%f")
;;現在行のハイライト
(defface my-hl-line-face
  ;;背景色がdarkなら紺
  '((((class color) (background dark))
     (:background "NavyBlue" t))
    ;;背景がlightならば緑
    (((class color) (background light))
     (:background "LightGoldenrodYellow" t))
    (t (:blod t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
(global-hl-line-mode t)



;;対応するカッコ表示
(show-paren-mode 1)
;;行番号桁番号表示
(line-number-mode t)(column-number-mode t)

;;Auto Complete Modeの設定

;;Cの全自動インデント設定
(add-hook 'c-mode-hook

'(lambda ()
(c-set-style "k&r") ;;k&rスタイル
(setq c-auto-newline t) ;自動インデントを有効にする
(setq tab-width 4) ;;タブ幅４
(setq c-basic-offset 4) ;;基本タブ幅４
(setq indent-tabs-mode nil) ;インデントは空白文字で行う
(c-set-offset 'arglist-close 0) ;関数の引数リストの閉じ括弧はインデントしない
))

;;cppの全自動インデント設定
; style I want to use in c++ mode
(c-add-style "my-style" 
	     '("stroustrup"
	       (indent-tabs-mode . nil)        ; use spaces rather than tabs
	       (c-basic-offset . 4)            ; indent by four spaces
	       (c-offsets-alist . ((inline-open . 0)  ; custom indentation rules
				   (brace-list-open . 0)
				   (statement-case-open . +)))))

(defun my-c++-mode-hook ()
  (c-set-style "my-style")        ; use my-style defined above
  (auto-fill-mode)         
  (c-toggle-auto-hungry-state 1))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;;Ruby-mode
(custom-set-variables
 '(ruby-insert-encoding-magic-comment nil))

(require 'ruby-mode)
(defun ruby-mode-set-encoding () nil)
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(autoload 'ruby-mode "ruby-mode" "Major mode for editing Ruby code" t)

;Automatic indentation
(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq tab-width 2)
             (setq ruby-indent-level tab-width)
             (setq ruby-deep-indent-paren-style nil)
             (local-set-key"\r" 'newline-and-indent)))
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;Electric commands




;;auto-installの設定
;;(when (require 'auto-install nil t)
  ;;インストールディレクトリの設定。初期値は~/.emacs.d/auto-install/
  ;;(setq auto-install-directory "~/.emacs.d/elisp/")
  ;;EmacsWikiに登録されているelispの名前を取得
  ;;(auto-install-update-emacswiki-package-name t)
  ;;必要であればプロキシの設定を行う
  ;;(set url-prozy-services '(("http" . "localhost:8339")))
;;install-elispの関数を利用可能にする
  ;;(auto-install-compatibility-setup))
	  

(put 'upcase-region 'disabled nil)
