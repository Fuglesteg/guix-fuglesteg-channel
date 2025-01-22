(define-module (fuglesteg packages stumpwm)
  #:use-module (guix packages)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module ((guix licenses) #:prefix license:))

(define-public sbcl-stumpwm-stump-regkey
  (let ((commit "2e6dd1dff820447ab62c0cced78de254c72ca9fb")
        (revision "0"))
  (package 
   (name "sbcl-stumpwm-stump-regkey")
   (version (git-version "0.1" revision commit))
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/fuglesteg/stump-regkey")
           (commit commit)))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1lh3sgk45cy6ja9z9s04rfcpv183p9d66dsy4x14pqm40dqkzbij"))))
   (build-system asdf-build-system/sbcl)
   (arguments
    '(#:asd-systems '("stump-regkey")))
   (inputs (list stumpwm sbcl-clx))
   (home-page "https://github.com/fuglesteg/stump-regkey")
   (synopsis "Simple library for registering keysyms to the X keyboard layout")
   (description "Simple library for registering keysyms to the X keyboard layout. It is meant to be used with stumpwm:window-send-string to add additional mappings that are not part of the keyboard layout")
   (license license:gpl3+))))
