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
   (version "1.2")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/Fuglesteg/packup")
           (commit "58c687a360e54cc82dfe9d5bac9ced8504f10928")))
     (sha256 (base32 "1d2gc4rhsbmq32d7hrrkdfdl15n4zib046rcxmk9sbgvyixb1c6g"))
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
          
