;解决win10卡的问题
;; 设置垃圾回收，在Windows下，emacs25版本会频繁出发垃圾回收，所以需要设置
(when (eq system-type 'windows-nt)
(setq gc-cons-threshold (* 512 1024 1024))
(setq gc-cons-percentage 0.5)
(run-with-idle-timer 5 t #'garbage-collect)
;; 显示垃圾回收信息，这个可以作为调试用
;; (setq garbage-collection-messages t)
)
;配置emacs包管理的源
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
; initial package.el
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    material-theme))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally


;elpy
;; elpy---主角
(require 'elpy)

(defvar myPackages
  '(better-defaults
    elpy ;; add the elpy package
    material-theme))
(elpy-enable)

;; 自动完成：company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode); 全局开启
(setq company-show-numbers t); 显示序号
(setq company-idle-delay 0.2); 菜单延迟
(setq company-minimum-prefix-length 1); 开始补全字数




;; 语法检查：flycheck
(add-hook 'after-init-hook #'global-flycheck-mode);全局开启

; 关闭flymake，使用flycheck
(when (require 'flycheck nil t)
  (setq elpy-modules(delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;全屏
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_net_wm_state" 32
   '(2 "_net_wm_state_fullscreen" 0)))

;;将打开配置文件绑定到键<f12>
(global-set-key (kbd "<f12>") 'open-init-file)
;;显示行号
;(global-linum-mode 1)
;;设置字体
(set-default-font "consolas")
;;设置字体大小
(set-face-attribute 'default nil :height 160)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (avy-flycheck jedi-direx jedi company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
; 开启全局 company 补全
;(global-company-mode 1)
; 自定义按键
(global-set-key [f11] 'my-fullscreen)
(put 'upcase-region 'disabled nil)
; python environment                              
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t) ; optional                                                                                                                                      
(setq jedi:complete-on-dot t) ;optional
