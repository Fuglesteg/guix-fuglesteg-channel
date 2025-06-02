(define-module (fuglesteg packages packup)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages rsync))

(define-public packup
  (package
   (name "packup")
   (version "1.1")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/Fuglesteg/packup")
           (commit "87cde1320b74b527c6f7d975ad870731f24a8d62")))
     (sha256 (base32 "02mdikjcl5vz7hpk0gh9v0l8glary2wmibw1k5aq2mjhz7l66n87"))
     (file-name (git-file-name name version))))
   (build-system copy-build-system)
   (arguments
    (list
     #:phases #~(modify-phases %standard-phases
                               (add-before 'install 'modify-shebang
                                           (lambda _
                                             (substitute* "packup.lisp"
                                                          (("^#!.*") (string-append "#!" #$sbcl "/bin/sbcl --script"))
                                                          (("rsync") (string-append #$rsync "/bin/rsync"))))))
     #:install-plan #~(list '("packup.lisp" "bin/packup"))))
   (inputs (list sbcl rsync))
   (license license:expat)
   (synopsis "") (description "") (home-page "")))
          
