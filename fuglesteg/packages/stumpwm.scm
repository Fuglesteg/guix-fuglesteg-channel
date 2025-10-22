(define-module (fuglesteg packages stumpwm)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages sdl)
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

(define-public sbcl-stumpwm-sdl-fonts
  (let ((commit "sdl2-ttf")
        (revision "1"))
    (package
     (name "sbcl-stumpwm-sdl-fonts")
     (version (git-version "0.0.1" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Fuglesteg/stumpwm-contrib.git")
             (commit commit)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "08j4l0zar14jx5wzr2k0m8inxwjbj41gz1082ljg3f7yacc0li5v"))))
     (build-system asdf-build-system/sbcl)
     (inputs
      (list stumpwm
            sdl2
            sdl2-ttf
            sbcl-cffi))
     (arguments
      (list #:asd-systems ''("sdl-fonts")
            #:phases
            #~(modify-phases %standard-phases
                             (add-after 'unpack 'patch-sdl-dependencies
                                        (lambda _
                                          (substitute* "util/sdl-fonts/sdl-fonts.lisp"
                                                       (("libSDL2-2.0.so.0")
                                                        (string-append #$sdl2 "/lib/libSDL2.so"))
                                                       (("libSDL2_ttf-2.0.so.0")
                                                        (string-append #$sdl2-ttf "/lib/libSDL2_ttf.so"))))))))
     (home-page "https://github.com/stumpwm/stumpwm-contrib")
     (synopsis "StumpWM sdl based font rendering")
     (description "This package provides and sdl based font renderer for StumpWM.")
     (license (list license:gpl2+ license:gpl3+ license:bsd-2)))))
