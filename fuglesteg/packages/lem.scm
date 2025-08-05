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
  (let ((commit "cb19321345d6fd13dc3ca59d4d5b9a6b14cc00b1")
        (revision "0"))
  (package
   (name "sbcl-lem-extension-manager")
   (version (git-version "0.1" revision commit))
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/lem-project/lem-extension-manager")
           (commit commit)))
     (sha256
      (base32 "1g210cfrbjbdb395wnzb5hax2isq0d5990jhzcxj7kp171dydynf"))
     (file-name (git-file-name name version))))
   (build-system asdf-build-system/sbcl)
   (inputs (list sbcl-alexandria))
   (description "") (synopsis "") (home-page "") (license license:expat))))

(define-public lem-latest
  (let ((revision "0")
        (commit "abba5c2171a71b19e9fdbfb22378709e3807722c"))
    (package
     (inherit lem)
     (name "lem")
     (version (git-version "2.3.0" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/lem-project/lem")
             (commit commit)))
       (sha256
        (base32 "02dn7pqjqcb5cs7psgykirp5h4mk8n87xz3j0x7b3kw5x62gax6r"))
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
