(define-module (fuglesteg packages picom)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system meson)
  #:use-module (gnu packages datastructures)
  #:use-module (gnu packages docbook)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages ruby))

(define-public picom
  (package
    (name "picom")
    (version "12.5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/yshui/picom")
             (commit (string-append "v" version))))
       (sha256
        (base32
         "1skkchrlir9si9ljawg0xcgpfnd2macw7ny5vhx5f5zk7b7iphhz"))
       (file-name (string-append "picom-" version))))
    (build-system meson-build-system)
    (inputs
     (list dbus
           libconfig
           libepoxy
           libev
           libx11
           libxext
           libxdg-basedir
           mesa
           pcre2
           pixman
           uthash
           xcb-util
           xcb-util-renderutil
           xcb-util-image
           xprop))
    (native-inputs
     (list pkg-config xorgproto ruby-asciidoctor))
    (arguments
     (list #:build-type "release"
           #:configure-flags #~'("-Dwith_docs=true")
           #:phases
           #~(modify-phases %standard-phases
               ;; This file would be patched by 'patch-dot-desktop-files but
               ;; only in share/applications and not etc/xdg/autostart, so
               ;; manually patch it before it is installed in either location.
               ;; The 'patch-dot-desktop-files phase is still needed for other
               ;; .desktop files.
               (add-after 'unpack 'patch-autostart-files
                 (lambda _
                   (substitute* "picom.desktop"
                     (("Exec=")
                      (string-append "Exec=" #$output "/bin/"))))))))
    (home-page "https://github.com/yshui/picom")
    (synopsis "Compositor for X11, forked from Compton")
    (description
     "Picom is a standalone compositor for Xorg, suitable for use
with window managers that do not provide compositing.

Picom is a fork of compton, which is a fork of xcompmgr-dana,
which in turn is a fork of xcompmgr.")
    (license (list license:expat      ; The original compton license.
                   license:mpl2.0)))) ; License used by new picom files.
