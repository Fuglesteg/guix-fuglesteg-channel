(define-module (fuglesteg packages lem)
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

(define webview
  (let ((commit "3ab4b5d722438fc8a13e6ca830c5e2372d19a01d")
        (revision "0"))
  (package
   (name "webview")
   (version (git-version "0.1" revision commit))
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/webview/webview")
           (commit commit)))
     (sha256
      (base32 "0xfbcwsgjxsqb1whp18crajhqvm5di7dawrn4n6m08lzbmvahsm6"))
     (file-name (git-file-name name version))))
   (build-system cmake-build-system)
   (arguments
    '(#:tests? #f))
   (native-inputs (list pkg-config doxygen graphviz))
   (inputs (list webkitgtk))
   (description "") (synopsis "") (home-page "") (license license:expat))))

(define sbcl-cl-webview
  (let ((commit "float-trap-divide-by-zero-masked")
        (revision "0"))
  (package
   (name "cl-webview")
   (version (git-version "0.1" revision commit))
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/fuglesteg/webview")
           (commit commit)))
     (sha256
      (base32 "1kn5hlgdsbxjk7gkv6gqsc20cfkgc04kzdxpjysnbf9v678r0g3b"))
     (file-name (git-file-name name version))
       (snippet
        #~(begin
            (use-modules (guix build utils))
            (delete-file-recursively "c")
            (delete-file-recursively "lib")
            (mkdir "lib")
            (mkdir "lib/linux")
            (display (string-append #$webview "/lib"))
            (symlink (string-append #$webview "/lib") "lib/linux/x64")))))
   (build-system asdf-build-system/sbcl)
   (arguments
    '(#:asd-systems (list "webview")))
   (inputs (list sbcl-cffi sbcl-float-features webview))
   (description "") (synopsis "") (home-page "") (license license:expat))))

(define sbcl-jsonrpc
  (let ((commit "2af1e0fad429ee8c706b86c4a853248cdd1be933")
        (revision "2"))
    (package
      (name "sbcl-jsonrpc")
      (version (git-version "0.3.2" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cxxxr/jsonrpc")
               (commit commit)))
         (file-name (git-file-name "jsonrpc" version))
         (sha256
          (base32 "0kd550fsklsc4h0fj8jl6g4z5ldb8ba9dn68s7ykv3myaiwgsy1p"))))
      (build-system asdf-build-system/sbcl)
      (arguments
       '(#:asd-systems (list
                        "jsonrpc"
                        "jsonrpc/transport/stdio"
                        "jsonrpc/transport/websocket"
                        "jsonrpc/transport/local-domain-socket")))
      (native-inputs (list sbcl-rove))
      (inputs (list sbcl-clack
                    sbcl-http-body
                    sbcl-lack
                    sbcl-yason
                    sbcl-bordeaux-threads
                    sbcl-event-emitter
                    sbcl-alexandria
                    sbcl-dissect
                    sbcl-trivial-timeout
                    sbcl-chanl
                    sbcl-vom
                    sbcl-usocket
                    sbcl-websocket-driver))
      (home-page "https://github.com/cxxxr/jsonrpc")
      (synopsis "JSON-RPC 2.0 server/client for Common Lisp")
      (description
       "This package provides a JSON-RPC 2.0 server/client for Common Lisp.")
      (license license:bsd-2))))

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

(define sbcl-cl-frugal-uuid
  (let ((commit "9e766a7f0487e4d3ba0ee7c4b1b4e046f531f0b3")
        (revision "0"))
    (package
      (name "sbcl-cl-frugal-uuid")
      (version (git-version "0.0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/ak-coram/cl-frugal-uuid")
               (commit commit)))
         (file-name (git-file-name "cl-frugal-uuid" version))
         (sha256
          (base32 "1naviw6qksf2zh2wsr9lqpdjfy10nfrc1pc0liz1hrq14f15lsrm"))))
      (build-system asdf-build-system/sbcl)
      (arguments
       '(#:asd-systems (list "frugal-uuid")))
      (native-inputs (list sbcl-fiveam))
      (home-page "https://github.com/cxxxr/jsonrpc")
      (synopsis "JSON-RPC 2.0 server/client for Common Lisp")
      (description
       "This package provides a JSON-RPC 2.0 server/client for Common Lisp.")
      (license license:bsd-2))))

(define-public lem-latest
  (let ((revision "0")
        (commit "c9098c5d467e659acc67f0abbcd691126c9dc330"))
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
        (base32 "1g2vd66xg311rkkcqrdm0q7w0ixky738biym4l0cjdfb3dligvcv"))
       (file-name (git-file-name name version))
       (snippet
        #~(begin
            (use-modules (guix build utils))
            (delete-file-recursively "roswell")
            ;; Delete precompiled shared object files.
            (delete-file-recursively "extensions/terminal/lib")))))
     (inputs
      (list
       libvterm sbcl-alexandria sbcl-trivia sbcl-cl-webview
       sbcl-trivial-gray-streams sbcl-trivial-types sbcl-cl-ppcre
       sbcl-closer-mop sbcl-iterate sbcl-lem-mailbox
       sbcl-inquisitor sbcl-babel sbcl-bordeaux-threads
       sbcl-yason sbcl-log4cl sbcl-split-sequence
       sbcl-cl-str sbcl-dexador sbcl-3bmd sbcl-cl-frugal-uuid
       sbcl-micros sbcl-lisp-preprocessor sbcl-trivial-ws
       sbcl-trivial-open-browser sbcl-sdl2 sbcl-sdl2-ttf
       sbcl-sdl2-image sbcl-trivial-main-thread sbcl-cffi
       sbcl-cl-charms sbcl-cl-setlocale sbcl-log4cl
       sbcl-jsonrpc sbcl-usocket sbcl-quri
       sbcl-cl-change-case sbcl-async-process sbcl-cl-iconv
       sbcl-esrap sbcl-parse-number sbcl-cl-package-locks
       sbcl-slime-swank sbcl-trivial-utf-8 sbcl-lem-extension-manager
       sbcl-deploy sbcl-cl-mustache cl-command-line-arguments)))))
