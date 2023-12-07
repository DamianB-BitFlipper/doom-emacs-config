;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("TAB" . 'copilot-accept-completion)
              ("<tab>" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

;; Set up the python DAP debugger
(after! dap-mode
  ;; Important: Be sure to run M-x dap-cpptools-setup to setup
  ;; the adapter before using it the first time.
  (require 'dap-cpptools)
  (require 'dap-python)
  (setq dap-python-debugger 'debugpy)

  ;; Make dap-debugging have some reasonable templates
  (dap-register-debug-template
   "cpptools::Run Configuration"
   (list :type "cppdbg"
         :request "launch"
         :name "cpptools::Run Configuration"
         :MIMode "lldb"
         :TargetArchitecture "arm64"
         :program "${workspaceFolder}/${fileBasenameNoExtension}"
         :cwd "${workspaceFolder}"))
  )

;; Give dap some reasonable key bindings
(map! :map dap-mode-map
      :leader
      :prefix ("d" . "dap")
      ;; basics
      :desc "dap next"          "n" #'dap-next
      :desc "dap step in"       "i" #'dap-step-in
      :desc "dap step out"      "o" #'dap-step-out
      :desc "dap continue"      "c" #'dap-continue
      :desc "dap hydra"         "h" #'dap-hydra
      :desc "dap debug restart" "r" #'dap-debug-restart
      :desc "dap debug start"   "s" #'+debugger/start
      :desc "dap debug choose"  "S" #'dap-debug
      :desc "dap debug quit"    "q" #'+debugger/quit

      ;; debug
      :prefix ("dd" . "Debug")
      :desc "dap debug recent"  "r" #'dap-debug-recent
      :desc "dap debug last"    "l" #'dap-debug-last

      ;; eval
      :prefix ("de" . "Eval")
      :desc "eval"                "e" #'dap-eval
      :desc "eval region"         "r" #'dap-eval-region
      :desc "eval thing at point" "s" #'dap-eval-thing-at-point
      :desc "add expression"      "a" #'dap-ui-expressions-add
      :desc "remove expression"   "d" #'dap-ui-expressions-remove

      :prefix ("db" . "Breakpoint")
      :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
      :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
      :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
      :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message
      :desc "dap breakpoint delete all"  "d" #'dap-breakpoint-delete-all)

;; Make the command key the M meta and option super ('s')
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;; Set dash-docs to use the system default browser
(after! dash-docs
  (setq dash-docs-browser-func #'browse-url))

;; Disable auto-comments
(setq comment-line-break-function nil)

;;
;; Remap some keybindings
;;

;; Set the keybindings after package has been loaded
;; to overwrite any settings that may have been set
(after! company
  (map! :map company-active-map
        "TAB" #'company-complete-selection
        "<tab>" #'company-complete-selection))

;; Keybindings with no package loading dependency
(map! :map
      'override
      :desc "Activate Conda Env" "s-e" #'conda-env-activate
      :desc "Deactivate Conda Env" "s-E" #'conda-env-deactivate

      :desc "Go to beginning of function" "C-M-;" #'beginning-of-defun
      :desc "Go to end of function" "C-M-'" #'end-of-defun

      :leader
      :desc "Compile" "c C" #'compile
      :desc "Recompile" "c c" #'recompile

      :desc "Restore last session" "w r" #'+workspace/restore-last-session
      :desc "Rename workspace" "w R" #'+workspace/rename
      :desc "Switch to left workspace" "w <left>"#'+workspace/switch-left
      :desc "Switch to right workspace" "w <right>" #'+workspace/switch-right)
