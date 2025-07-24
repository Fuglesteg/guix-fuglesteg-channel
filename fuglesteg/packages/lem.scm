(define-module (fuglesteg packages lem)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix transformations)
  #:use-module (guix git-download)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages text-editors)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module ((guix licenses) #:prefix license:))

(define-public sbcl-lem-extension-manager
  (let ((commit "optional-ql-dependency")
        (revision "0"))
  (package
   (name "sbcl-lem-extension-manager")
   (version (git-version "0.1" revision commit))
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/fuglesteg/lem-extension-manager")
           (commit commit)))
     (sha256
      (base32 "06jm7vja88jwjxysc9v63sy3qpi1v55s46sm5k0h8nv3mf678r32"))
     (file-name (git-file-name name version))))
   (build-system asdf-build-system/sbcl)
   (inputs (list sbcl-alexandria))
   (description "") (synopsis "") (home-page "") (license license:expat))))

(define-public lem-latest
  (let ((revision "0")
        (commit "2f07fbb1e09dc89c89473a9b83d7904b2ba51690"))
    (package
     (inherit lem)
     (name "lem")
     (version (git-version "2.3.0" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/fuglesteg/lem/")
             (commit commit)))
       (sha256
        (base32 "0xkzi68n5wmy9n0k8v442byphyfg9h7pwcsvl372xvw7g2x3brv3"))
       (file-name (git-file-name name version))
       (snippet
        #~(begin
            (use-modules (guix build utils))
            (delete-file-recursively "roswell")
            ;; Delete precompiled shared object files.
            (delete-file-recursively "extensions/terminal/lib")))))
     (inputs 
      (list
       libvterm sbcl-alexandria sbcl-trivia
       sbcl-trivial-gray-streams sbcl-trivial-types sbcl-cl-ppcre
       sbcl-closer-mop sbcl-iterate sbcl-lem-mailbox
       sbcl-inquisitor sbcl-babel sbcl-bordeaux-threads
       sbcl-yason sbcl-log4cl sbcl-split-sequence
       sbcl-cl-str sbcl-dexador sbcl-3bmd
       sbcl-micros sbcl-lisp-preprocessor sbcl-trivial-ws
       sbcl-trivial-open-browser sbcl-sdl2 sbcl-sdl2-ttf
       sbcl-sdl2-image sbcl-trivial-main-thread sbcl-cffi
       sbcl-cl-charms sbcl-cl-setlocale sbcl-log4cl
       sbcl-jsonrpc sbcl-usocket sbcl-quri
       sbcl-cl-change-case sbcl-async-process sbcl-cl-iconv
       sbcl-esrap sbcl-parse-number sbcl-cl-package-locks
       sbcl-slime-swank sbcl-trivial-utf-8 sbcl-lem-extension-manager)))))
