(define-module (fuglesteg packages pegasus)
               #:use-module (guix packages)
               #:use-module (guix gexp)
               #:use-module (guix git-download)
               #:use-module (guix build-system qt)
               #:use-module ((guix licenses) #:prefix license:)
               #:use-module (gnu packages qt)
               #:use-module (gnu packages sdl)
               #:use-module (gnu packages bash)
               #:use-module (gnu packages gstreamer))

(define-public pegasus-frontend
  (package
    (name "pegasus-frontend")
    (version "weekly_2024w38")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/mmatyas/pegasus-frontend")
             (commit version)
             (recursive? #t)))
       (sha256
        (base32 "04773v3b50wya7w3hgy6j8sli07aimsfc8njqsycg9gbqygm183l"))
       (file-name (git-file-name name version))))
    (build-system qt-build-system)
    (arguments
     (list
      #:qtbase qtbase-5
      #:phases #~(modify-phases %standard-phases
                   (add-after 'qt-wrap 'gst-wrap
                     ;; Set required environment variable for gstreamer plugins
                     ;; Used for video playback
                     (lambda _
                       (wrap-program (string-append #$output "/bin/pegasus-fe")
                         `("GST_PLUGIN_SYSTEM_PATH" suffix
                           (,(string-append #$gst-plugins-good
                                            "/lib/gstreamer-1.0"))))))
                   (add-before 'check 'set-display
                     (lambda _
                       ;; Required for tests to not attempt to start an OpenGL context
                       (setenv "QT_QUICK_BACKEND" "software"))))))
    (inputs (list sdl2
                  qtbase-5
                  qtsvg-5
                  qtdeclarative-5
                  qtgraphicaleffects
                  qtmultimedia-5
                  qtgamepad
                  gst-plugins-good ; For video playback
                  bash-minimal)) ; For wrap-program
    (native-inputs (list qttools-5))
    (synopsis "Customizable graphical emulator frontend")
    (description
     "Pegasus is a graphical frontend for browsing your game library and launching all
   kinds of emulators from the same place.  It's focusing on customizability, cross
   platform support (including embedded) and high performance.")
    (home-page "https://pegasus-frontend.org")
    (license license:gpl3)))

