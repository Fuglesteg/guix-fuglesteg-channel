(define-module (fuglesteg packages lem)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix transformations)
  #:use-module (guix git-download)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages text-editors)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module ((guix licenses) #:prefix license:))

(define-public lem-latest
               (let ((revision "1")
                     (commit "672a649674d3c75b91b3da777df0d490a4bb92a0"))
                 (package
                   (inherit lem)
                   (name "lem")
                   (version (git-version "2.3.0" revision commit))
                   (source
                     (origin
                       (method git-fetch)
                       (uri (git-reference
                              (url "https://github.com/lem-project/lem/")
                              (commit commit)))
                       (sha256
                         (base32 "1fscqlh10dhh9p642l8v46ilzazy4b61p2pk8kld2dnl1kj6kxsf"))
                       (file-name (git-file-name name version))
                       (snippet
                         #~(begin
                             (use-modules (guix build utils))
                             (delete-file-recursively "roswell")
                             ;; Delete precompiled shared object files.
                             (delete-file-recursively "extensions/terminal/lib"))))))))
