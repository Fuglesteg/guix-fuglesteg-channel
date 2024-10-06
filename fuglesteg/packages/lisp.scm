(define-module (fuglesteg packages lisp)
               #:use-module (guix packages)
               #:use-module (guix git-download)
               #:use-module (guix build-system asdf)
               #:use-module ((guix licenses) #:prefix license:)
               #:use-module (gnu packages lisp-xyz)
               #:use-module (gnu packages gl))

(define-public sbcl-glfw
               (let ((commit "9054b7f9e8806a15b8f71031b6d437af48c79279")
                     (revision "0"))
                 (package
                   (name "sbcl-glfw")
                   (version (git-version "1.0" revision commit))
                   (source
                     (origin
                       (method git-fetch)
                       (uri (git-reference
                              (url "https://github.com/Shirakumo/glfw")
                              (commit commit)))
                       (file-name (git-file-name name version))
                       (sha256
                         (base32 "1sx1rpl8ibajd8bjgz1qapqpyz4gdca2gffwwp5vig0c8hiic2k2"))))
                   (build-system asdf-build-system/sbcl)
                   (arguments
                     '(#:asd-systems '("glfw")))
                   (inputs (list sbcl-cl-opengl
                                 glfw))
                   (home-page "https://shirakumo.github.io/glfw/")
                   (description "An up-to-date bindings library to the most recent GLFW OpenGL context management library")
                   (synopsis "Common lisp bindings for GLFW")
                   (license license:zlib))))
