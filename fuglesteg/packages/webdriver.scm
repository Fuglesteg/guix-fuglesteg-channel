(define-module (fuglesteg packages webdriver)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix transformations)
  #:use-module (guix git-download)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages lisp-check)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages text-editors)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module (guix build-system cmake)
  #:use-module ((guix licenses) #:prefix license:))

(define-public sbcl-cl-webdriver-client
  (let ((commit "3c2c377fe548504071cbd29c7ba8b9ccb8588a74")
        (revision "0"))
  (package
   (name "cl-webdriver-client")
   (version (git-version "0.1" revision commit))
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/copyleft/cl-webdriver-client")
           (commit commit)))
     (sha256
      (base32 "1975yyvvdxg11vgpyx93nkqr5x6i1xy47230vc40yd0c9bn6lpbr"))
     (file-name (git-file-name name version))))
   (build-system asdf-build-system/sbcl)
   (arguments (list #:tests? #f))
   (inputs (list sbcl-dexador
                 sbcl-quri
                 sbcl-cl-json
                 sbcl-alexandria
                 sbcl-split-sequence
                 sbcl-assoc-utils))
   (description "") (synopsis "") (home-page "") (license license:expat))))
