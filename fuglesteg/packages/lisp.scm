(define-module (fuglesteg packages lisp)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages lisp)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages gl))

(define-public sbcl-common-doc
  (package
   (name "sbcl-common-doc")
   (version "1.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/CommonDoc/common-doc")
           (commit "bcde4cfee3d34482d9830c8f9ea45454c73cf5aa")))
     (sha256 (base32 "0bzc4w37cq5mbkd15vxziks6nq58yad04mki4nwy5w6pza7z0faa"))
     (file-name (git-file-name name version))))
   (build-system asdf-build-system/sbcl)
   (arguments '(#:tests? #f
                #:phases (modify-phases %standard-phases
                          (add-after 'unpack 'delete-unused-systems
                           (lambda _
                             (for-each delete-file
                                       '("common-doc-contrib.asd"
                                         "common-doc-gnuplot.asd"
                                         "common-doc-graphviz.asd"
                                         "common-doc-include.asd"
                                         "common-doc-plantuml.asd"
                                         "common-doc-split-paragraphs.asd"
                                         "common-doc-test.asd"
                                         "common-doc-tex.asd")))))))
   (inputs (list sbcl-trivial-types
                 sbcl-local-time
                 sbcl-quri
                 sbcl-anaphora
                 sbcl-alexandria
                 sbcl-closer-mop))
   (synopsis "") (description "") (license license:expat) (home-page "")))

(define-public sbcl-common-html
  (package
   (name "sbcl-common-html")
   (version "1.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/CommonDoc/common-html")
           (commit "96987bd9db21639ed55d1b7d72196f9bc58243fd")))
     (sha256 (base32 "1i11w4l95nybz5ibnaxrnrkfhch2s9wynqrg6kx6sl6y47khq1xz"))
     (file-name (git-file-name name version))))
   (build-system asdf-build-system/sbcl)
   (arguments '(#:tests? #f))
   (inputs (list sbcl-anaphora sbcl-alexandria sbcl-common-doc sbcl-plump))
   (synopsis "") (description "") (license license:expat) (home-page "")))

(define-public sbcl-commondoc-markdown
  (package
   (name "sbcl-commondoc-markdown")
   (version "1.2")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/40ants/commondoc-markdown")
           (commit "7abd28806bec33f291b982684d143edddb5cc32a")))
     (sha256 (base32 "12n8yx8jhz8713r63gmrymplm1mfczm7q7a343d13wl6gng1gjs1"))
     (file-name (git-file-name name version))))
   (build-system asdf-build-system/sbcl)
   (arguments '(#:tests? #f))
   (inputs (list sbcl-3bmd 
                 sbcl-common-doc 
                 sbcl-plump 
                 sbcl-common-html 
                 sbcl-ironclad
                 sbcl-cl-str))
   (synopsis "") (description "") (license license:expat) (home-page "")))

(define-public sbcl-glfw
  (let ((commit "9054b7f9e8806a15b8f71031b6d437af48c79279")
        (revision "0"))
    (package
     (name "sbcl-glfw")
     (version (git-version "1.0" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Shirakumo/glfw")
             (commit commit)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1sx1rpl8ibajd8bjgz1qapqpyz4gdca2gffwwp5vig0c8hiic2k2"))))
     (build-system asdf-build-system/sbcl)
     (arguments
      '(#:asd-systems '("glfw")))
     (inputs (list sbcl-cl-opengl
                   glfw))
     (home-page "https://shirakumo.github.io/glfw/")
     (description "An up-to-date bindings library to the most recent GLFW OpenGL context management library")
     (synopsis "Common lisp bindings for GLFW")
     (license license:zlib))))

(define-public sbcl-sha3
  (let ((commit "a4baa05e72ee05aba545152a2ffe2e46fbfa3d4b")
        (revision "0"))
    (package
     (name "sbcl-sha3")
     (version (git-version "1.0" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/pmai/sha3")
             (commit commit)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0jl59js4n1gc08j2bcwf0d1gy82lf7g53b639dwh6b0milbqh7gz"))))
     (build-system asdf-build-system/sbcl)
     (home-page "")
     (description "")
     (synopsis "")
     (license license:expat))))

(define-public sbcl-deploy-latest
  (let ((commit "13df110e31a50651c9d9040f34f58e85f3144d6a")
        (revision "1"))
  (package
   (inherit sbcl-deploy)
   (name "sbcl-deploy")
   (version (git-version "1.1" revision commit))
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/Shinmera/deploy")
           (commit commit)))
     (file-name (git-file-name name version))
     (sha256
      (base32 "0xbnrkfx4gshvn7fa726017m3zrfyrblc9ij10xvcdk5h86j66zj"))))
   (native-inputs
    (list sbcl-cl-mpg123
          sbcl-cl-out123))
   (inputs
    (list sbcl-cffi
          sbcl-documentation-utils
          sbcl-trivial-features
          sbcl-pathname-utils
          sbcl-sha3)))))