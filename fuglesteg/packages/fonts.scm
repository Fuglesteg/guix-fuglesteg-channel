(define-module (fuglesteg packages fonts)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system font))

(define-public font-nerd-mononoki
  (package
    (name "font-nerd-mononoki")
    (version "v3.0.2")
    (source (origin
             (method url-fetch)
             (uri (string-append 
                    "https://github.com/ryanoasis/nerd-fonts/releases/download/"
                    version
                    "/Mononoki.zip"))
             (sha256
              (base32
               "13mj185jnwnipwh0gwl36p6jkdjxz034vnfmc6nwgdsrci1yxpa1"))))
    (build-system font-build-system)
    (home-page "https://dejavu-fonts.github.io/")
    (synopsis "Mononoki nerd font")
    (description "Mononoki font patched as a nerd font")
    (license license:gpl3+)))
