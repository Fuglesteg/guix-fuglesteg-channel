(define-module (fuglesteg packages lem)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix gexp)
  #:use-module (gnu packages base)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages commencement)
  #:use-module (gnu packages lisp-check)
  #:use-module (gnu packages lisp-xyz))

(define sbcl-iconv
  (let ((commit "54900c3f00e19da15a9c65451bddde839d0a7f75")
        (revision "0"))
    (package
      (name "sbcl-iconv")
      (version (git-version "0.3" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/quek/cl-iconv")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1lpw95c02inifhdh9kkab9q92i5w9zd788dww1wly2p0a6kyx9wg"))))
      (build-system asdf-build-system/sbcl)
      (inputs (list sbcl-cffi libiconv))
      (home-page "https://github.com/quek/cl-iconv")
      (synopsis "iconv(man 3 iconv) library for Common Lisp")
      (description
       "This package provides CFFI bindings to convert between different
character encodings using iconv.")
      (license license:expat))))

(define sbcl-cl-setlocale
  (let ((commit "f660d07dac72bc3e99caae1c6c8a789991e2694c")
        (revision "0"))
    (package
      (name "sbcl-cl-setlocale")
      (version (git-version "1.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/shamazmazum/cl-setlocale")
               (commit commit)))
         (file-name (git-file-name "cl-setlocale" version))
         (sha256
          (base32 "0g1b89yj6n42ayf2074krk3h9yvglqxn54a6i3sxgpsqww2ll2a1"))))
      (build-system asdf-build-system/sbcl)
      (inputs (list sbcl-cffi))
      (native-inputs (list sbcl-fiveam))
      (home-page "https://github.com/shamazmazum/cl-setlocale")
      (synopsis "Wrapper around setlocale(3) usable with other CFFI libraries")
      (description
       "This library is a tiny wrapper around setlocale(3)
and can be used in conjunction with other FFI wrappers like cl-charms.")
      (license license:bsd-2))))

(define sbcl-lem-mailbox
  (let ((commit "12d629541da440fadf771b0225a051ae65fa342a")
        (revision "1"))
    (package
      (name "sbcl-lem-mailbox")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/lem-project/lem-mailbox")
               (commit commit)))
         (sha256
          (base32 "1qh9yq9ks0paplmbx0vj4nynx86igkv9kli396plpg9vc14qdgl5"))
         (file-name (git-file-name "cl-lem-mailbox" version))))
      (build-system asdf-build-system/sbcl)
      (inputs (list sbcl-bordeaux-threads sbcl-bt-semaphore sbcl-queues))
      (native-inputs (list sbcl-rove))
      (synopsis "ANSI CL adaptation of the SBCL mailbox utility")
      (description "ANSI CL adaptation of the SBCL mailbox utilty.
Tested on ABCL, but should work on any implementation.")
      (home-page "https://github.com/lem-project/lem-mailbox")
      (license license:expat))))

(define-public sbcl-micros
  (let ((commit "9fc7f1e5b0dbf1b9218a3f0aca7ed46e90aa86fd")
        (revision "1"))
    (package
      (name "sbcl-micros")
      (version (git-version "1.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/lem-project/micros")
               (commit commit)))
         (sha256
          (base32 "1p0s7a723w56vcgrbc7hgmkhnmjcb8nmc59im2wx9inm1la6mcbc"))
         (file-name (git-file-name "micros" version))
         (snippet #~(begin
                      (use-modules (guix build utils))
                      (substitute* "lsp-api.lisp"
                        (("ql:quickload")
                         "asdf:load-systems"))))))
      (build-system asdf-build-system/sbcl)
      (native-inputs (list sbcl-rove))
      (synopsis "SLIME/SWANK implementation for the Lem editor")
      (description
       "Micros is a SLIME/SWANK implementation meant for use by
the Lem editor for Common Lisp. Breaking changes in SLIME/SWANK
led Lem to maintain it's own fork to ease maintainance burden.")
      (home-page "https://github.com/lem-project/micros")
      (license license:expat))))

(define sbcl-async-process
  (let ((commit "9690530fc92b59636d9f17d821afa7697e7c8ca4")
        (revision "0"))
    (package
      (name "sbcl-async-process")
      (version (git-version "0.0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/lem-project/async-process")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1m2sfgfg6c0gqqy1pqsahsiw3j25y473mfw7sx0akkqbhwhm7mjb"))))
      (build-system asdf-build-system/sbcl)
      (inputs (list sbcl-cffi))
      (home-page "https://github.com/lem-project/async-process")
      (synopsis "Asynchronous process execution for Common Lisp")
      (description "This library provides an asynchronous process
execution mechanism for Common Lisp.")
      (license license:expat))))

(define sbcl-bt-semaphore
  (let ((commit "46b4bf315590f510d2d4ec5ca8908efbe68007e9")
        (revision "1"))
    (package
      (name "sbcl-bt-semaphore")
      (version (git-version "0.6.2" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/r-moeritz/bt-semaphore")
               (commit commit)))
         (sha256
          (base32 "0rl7yp36225z975hg069pywwlpchwn4086cgxwsi2db5mhghpr7l"))
         (file-name (git-file-name "cl-bt-semaphore" version))))
      (build-system asdf-build-system/sbcl)
      (inputs (list sbcl-bordeaux-threads))
      (native-inputs (list sbcl-clunit))
      (synopsis "Semaphore implementation for @code{bordeaux-threads}")
      (description
       "@code{bt-semaphore} is a semaphore implementation for use with
@code{bordeaux-threads}.

Since version 0.8.6, @code{bordeaux-threads}
supplies its own built-in semaphores. It is recommended to use those instead.")
      (home-page "https://github.com/r-moeritz/bt-semaphore")
      (license license:expat))))

(define-public sbcl-jsonrpc
  (let ((commit "62e25f0e0059e57e6ab4abe677e466a76052c439")
        (revision "1"))
    (package
      (name "sbcl-jsonrpc")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cxxxr/jsonrpc")
               (commit commit)))
         (file-name (git-file-name "jsonrpc" version))
         (sha256
          (base32 "0d3fl9jis6jfgx9mfbgyam9nb8smqxqd0ch9b61i3h73fcyp4211"))))
      (build-system asdf-build-system/sbcl)
      (native-inputs (list sbcl-rove))
      (inputs (list sbcl-clack
                    sbcl-http-body
                    sbcl-lack
                    sbcl-yason
                    sbcl-bordeaux-threads
                    sbcl-event-emitter
                    sbcl-alexandria
                    sbcl-dissect
                    sbcl-chanl
                    sbcl-vom
                    sbcl-usocket
                    sbcl-websocket-driver))
      (home-page "https://github.com/cxxxr/jsonrpc")
      (synopsis "JSON-RPC 2.0 server/client for Common Lisp")
      (description "This package provides a JSON-RPC 2.0
server/client for Common Lisp.")
      (license license:bsd-2))))

(define-public sbcl-trivial-utf-8
  (let ((commit "ba9b4ff11396a26dd7455ebfd426c07d7036e6be")
        (revision "0"))
    (package
      (name "sbcl-trivial-utf-8")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/fukamachi/trivial-utf-8")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1jz27gz8gvqdmvp3k9bxschs6d5b3qgk94qp2bj6nv1d0jc3m1l1"))))
      (build-system asdf-build-system/sbcl)
      (arguments
       ;; there is an issue with the asdf-build-system that mangles the system name due to the `-8`
       ;; being interpreted as part of the version. specifiy the system name explicitly to prevent this
       ;; from causing issues.
       '(#:asd-systems '("trivial-utf-8")))
      (home-page "https://github.com/fukamachi/trivial-utf-8")
      (synopsis "Common Lisp library for reading and writing UTF-8")
      (description "This is a library that provides functions for reading and writing UTF-8 bytes.")
      (license license:bsd-2))))

(define-public sbcl-hunchensocket
  (let ((commit "faf2c08452f18763e541bc7f121760669ac0f41a")
        (revision "0"))
    (package
      (name "sbcl-hunchensocket")
      (version (git-version "1.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/joaotavora/hunchensocket/")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1vhd009lwl62l1czmhsalblxmyz4x9v3nspjflpajwm1db5rnd7h"))))
      (build-system asdf-build-system/sbcl)
      (native-inputs (list sbcl-fiasco))
      (inputs
       (list
        sbcl-hunchentoot
        sbcl-alexandria
        sbcl-cl-base64
        sbcl-sha1
        sbcl-flexi-streams
        sbcl-chunga
        sbcl-trivial-utf-8
        sbcl-trivial-backtrace
        sbcl-cl-fad))
      (home-page "https://github.com/joaotavora/hunchensocket")
      (synopsis "WebSockets extension for Huchentoot")
      (description "This library provides a WebSockets extension for the Huchentoot web server.")
      (license license:expat))))

(define-public sbcl-websocket-driver
  (let ((commit "17ba5535fb1c4fe43e7e8ac786e8b61a174fcba3")
        (revision "0"))
    (package
      (name "sbcl-websocket-driver")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/fukamachi/websocket-driver")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1lj6xarr62199ladkml7qpgi86w94j4djrp54v9ch0zakni3rhj2"))))
      (build-system asdf-build-system/sbcl)
      (inputs
       (list
        sbcl-fast-websocket
        sbcl-fast-io
        sbcl-event-emitter
        sbcl-sha1
        sbcl-cl-base64
        sbcl-split-sequence
        sbcl-bordeaux-threads
        sbcl-babel
        sbcl-clack))
      (home-page "https://github.com/fukamachi/websocket-driver/")
      (synopsis "WebSocket server and client implementation in Common Lisp")
      (description "This library provides a WebSocket server and client implementation in Common Lisp.
It is designed to work with @code{cl-clack}, and has a replacable backend.")
      (license license:bsd-2))))

(define-public sbcl-trivial-ws
  (let ((commit "ebf1ec0ea26bdac4007e98e89f3a621dbfb4390a")
        (revision "0"))
    (package
      (name "sbcl-trivial-ws")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/ceramic/trivial-ws/")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0qmsf0dhmyhjgqjzdgj2yb1nkrijwp4p1j411613i45xjc2zd6m7"))))
      (build-system asdf-build-system/sbcl)
      (native-inputs
       (list
        sbcl-prove
        sbcl-find-port))
      (inputs
       (list
        sbcl-hunchensocket
        sbcl-websocket-driver
        sbcl-cl-async))
      (home-page "https://github.com/ceramic/trivial-ws")
      (synopsis "Common Lisp library for using WebSockets")
      (description "A Common Lisp library implementing a simple interface for using WebSockets.")
      (license license:expat))))

(define-public sbcl-lisp-preprocessor
  (let ((commit "cbed5952f3d98c84448c52d12255df9580451383")
        (revision "0"))
    (package
      (name "sbcl-lisp-preprocessor")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/cxxxr/lisp-preprocessor/")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0v0qhawcvgbxk06nfwyvcqwmqvzn2svq80l2rb12myr0znschhpi"))))
      (build-system asdf-build-system/sbcl)
      (native-inputs (list sbcl-rove))
      (inputs
       (list
        sbcl-alexandria
        sbcl-trivial-gray-streams
        sbcl-split-sequence
        sbcl-trivia
        sbcl-cl-ppcre))
      (home-page "https://github.com/cxxxr/lisp-preprocessor")
      (synopsis "Common Lisp embedded template engine")
      (description "This is a embedded template engine for Common Lisp.
It allows embedding Common Lisp code into text files that can expand out to be used as templates.")
      (license license:expat))))

(define-public sbcl-inquisitor
  (let ((commit "423fa9bdd4a68a6ae517b18406d81491409ccae8")
        (revision "1"))
    (package
      (name "sbcl-inquisitor")
      (version (git-version "0.5" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/t-sin/inquisitor/")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "08rkmqnwlq6v84wcz9yp31j5lxrsy33kv3dh7n3ccsg4kc54slzw"))))
      (build-system asdf-build-system/sbcl)
      (native-inputs (list sbcl-prove sbcl-babel))
      (inputs (list sbcl-flexi-streams sbcl-alexandria sbcl-anaphora))
      (home-page "https://github.com/t-sin/inquisitor")
      (synopsis
       "Encoding/end-of-line detection and external-format abstraction for Common Lisp")
      (description
       "Inquisitor is a cross-implementation library provding
encoding/end-of-line detection and external-format abstraction for Common Lisp.")
      (license license:expat))))

(define lem-base16-themes
  ;; keep private
  (let ((commit "07dacae6c1807beaeffc730063b54487d5c82eb0")
        (revision "0"))
    (package
      (name "lem-base16-themes")
      (version (git-version "0.0.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/lem-project/lem-base16-themes")
               (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0hqscypvp5rd8qiwwqh46lip0rjg4bpggjf7sjff7qxgimylk1aj"))))
      (build-system asdf-build-system/source)
      (home-page "https://github.com/lem-project/lem-base16-themes")
      (synopsis "Themes for Lem editor")
      (description "Themes for Lem editor.")
      (license license:expat))))

(define-public lem
  (let ((commit "2dcb47164bda78ff1eb8ccd2652f6d21676fde00")
        (revision "0"))
    (package
      (name "lem")
      (version (git-version "2.2.0" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/lem-project/lem/")
               (commit commit)))
         (sha256
          (base32 "1wdks9xwcj8anllg08ki6f0wf6rb6yi372rn2cnifw78y4d2b4nr"))
         (file-name (git-file-name name version))
         (snippet #~(begin
                      (use-modules (guix build utils))
                      ;; delete roswell-specific files since they aren't needed
                      (delete-file-recursively "roswell")))))
      (build-system asdf-build-system/sbcl)
      (outputs '("out" "ncurses"))
      (arguments
       '(#:asd-systems '("lem-sdl2/executable" "lem-ncurses")
         #:phases (modify-phases %standard-phases
                    (add-after 'unpack 'override-ql
                      (lambda _
                        (substitute* (find-files (getcwd) "\\.lisp$")
                          (("ql:quickload")
                           "asdf:load-systems"))))
                    (add-after 'override-ql 'set-default-implementation
                               (lambda _
                                 (substitute* "extensions/lisp-mode/implementation.lisp"
                                              (("\\*default-command\\* nil") "*default-command* \"sbcl\""))))
                    (add-after 'set-default-implementation 'redirect-home
                      (lambda _
                        (setenv "HOME" "/tmp")))
                    (add-after 'create-asdf-configuration 'build-program
                      (lambda* (#:key outputs #:allow-other-keys)
                        (begin
                          (build-program (string-append (assoc-ref outputs
                                                                   "out")
                                                        "/bin/lem")
                                         outputs
                                         #:dependencies '("lem-sdl2")
                                         #:entry-program '((lem:main)
                                                           0))
                          (build-program (string-append (assoc-ref outputs
                                                                   "ncurses")
                                                        "/bin/lem")
                                         outputs
                                         #:dependencies '("lem-ncurses")
                                         #:entry-program '((lem:main)
                                                           0))))))))
      (inputs (list
               ;; lem.asd
               sbcl-alexandria
               sbcl-trivia
               sbcl-trivial-gray-streams
               sbcl-trivial-types
               sbcl-cl-ppcre
               sbcl-closer-mop
               sbcl-iterate
               sbcl-micros
               sbcl-lem-mailbox
               sbcl-inquisitor
               sbcl-babel
               sbcl-bordeaux-threads
               sbcl-yason
               sbcl-log4cl
               sbcl-split-sequence
               sbcl-cl-str
               sbcl-dexador
               sbcl-3bmd
               sbcl-lisp-preprocessor
               sbcl-trivial-ws
               sbcl-trivial-open-browser
               ;; lem-sdl2
               sbcl-sdl2
               sbcl-sdl2-ttf
               sbcl-sdl2-image
               sbcl-trivial-main-thread
               ;; lem-ncurses
               sbcl-cffi
               sbcl-cl-charms
               sbcl-cl-setlocale
               ;; lem-language-server
               sbcl-log4cl
               sbcl-jsonrpc
               sbcl-usocket
               sbcl-quri
               sbcl-cl-change-case
               sbcl-async-process
               ;; lem-encodings-table
               sbcl-iconv
               ;; lem-vi-mode
               sbcl-esrap
               sbcl-parse-number
               sbcl-cl-package-locks
               ;; lem-scheme-mode
               sbcl-slime-swank
               ;; lem-jsonrpc
               sbcl-trivial-utf-8
               lem-base16-themes))
      (native-inputs (list sbcl-rove))
      (synopsis "Integrated IDE/editor for Common Lisp")
      (description "TODO")
      (home-page "http://lem-project.github.io/")
      (license license:expat))))
