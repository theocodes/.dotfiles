;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; used by gpg, magit etc
(setq user-full-name "Theo Felippe"
      user-mail-address "public@theocodes.com")

;; fonts
(setq doom-font (font-spec :family "JetBrains Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; theme
(setq doom-theme 'doom-molokai)

;; where to store org files
(setq org-directory "~/org/")

;; relative line numbers
(setq display-line-numbers-type 'relative)

;; fuzzy find in buffer
(map! [remap isearch-forward] 'swiper)

;; paste with Ctrl-Shift-v
(map! :g "C-S-v" #'yank)

;; no caching
(setq projectile-indexing-method 'alien
      projectile-enable-caching t)
