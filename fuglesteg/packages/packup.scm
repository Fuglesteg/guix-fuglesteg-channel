(define-module (fuglesteg packages packup)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages rsync))

(define-public packup
  (package
   (name "packup")
   (version "1.3")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/Fuglesteg/packup")
           (commit "5fcbbe5a49ad7235adedd1d3a19f609918a9652b")))
     (sha256 (base32 "14awasjkm1nwyh2c82wgizhvxcx0wg33rx57vdc5lb871s5alyr5"))
     (file-name (git-file-name name version))))
   (build-system copy-build-system)
   (arguments
    (list
     #:phases #~(modify-phases %standard-phases
                               (add-before 'install 'modify-shebang
                                           (lambda _
                                             (substitute* "packup.lisp"
                                                          (("^#!.*") (string-append "#!" #$sbcl "/bin/sbcl --script"))
                                                          (("ssh") (string-append #$openssh "/bin/ssh"))
                                                          (("rsync") (string-append #$rsync "/bin/rsync"))))))
     #:install-plan #~(list '("packup.lisp" "bin/packup"))))
   (inputs (list sbcl rsync openssh))
   (license license:expat)
   (synopsis "") (description "") (home-page "")))
