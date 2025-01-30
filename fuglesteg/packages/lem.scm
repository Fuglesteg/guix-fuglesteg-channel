(define-module (fuglesteg packages lem)
  #:use-module (guix packages)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages text-editors)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module ((guix licenses) #:prefix license:))

(define-public lem
  (package
    (inherit lem)
    (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/lem-project/lem/")
               (commit commit)))
         (sha256
          (base32 "0bmwcj1hdp5yi19afxg13rhkbcf6il8fqh81q55winqc35d0h6mn"))
         (file-name (git-file-name name version))
         (snippet
          #~(begin
              (use-modules (guix build utils))
              (delete-file-recursively "roswell")
              ;; Delete precompiled shared object files.
              (delete-file-recursively "extensions/terminal/lib")))))))
