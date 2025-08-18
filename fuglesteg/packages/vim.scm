(define-module (fuglesteg packages vim)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (srfi srfi-1)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages julia)
  #:use-module (gnu packages crates-web)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages node)
  #:use-module (gnu packages python-build)
  #:use-module (guix build-system cargo)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system pyproject)
  #:use-module (guix build-system tree-sitter)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system trivial)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system python)
  #:use-module (guix build-system pyproject)
  #:use-module (guix build-system vim)
  #:use-module (gnu packages)
  #:use-module (gnu packages commencement)
  #:use-module (gnu packages acl)
  #:use-module (gnu packages admin) ; For GNU hostname
  #:use-module (gnu packages attr)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages check)
  #:use-module (gnu packages code)
  #:use-module (gnu packages coq)
  #:use-module (gnu packages enlightenment)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gperf)
  #:use-module (gnu packages groff)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages image)
  #:use-module (gnu packages jemalloc)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages lua)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages text-editors)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages tree-sitter)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xorg))

(define-public tree-sitter
  (package
    (name "tree-sitter")
    (version "0.25.3")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/tree-sitter/tree-sitter")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0cck2wa17figxww7lb508sgwy9sbyqj89vxci07hiscr5sgdx9y5"))
              (modules '((guix build utils)))
              (snippet #~(begin
                           ;; Remove bundled ICU parts
                           (delete-file-recursively "lib/src/unicode")))))
    (build-system gnu-build-system)
    (inputs (list icu4c))
    (arguments
     (list #:phases
           #~(modify-phases %standard-phases
               (delete 'configure))
           #:tests? #f ; there are no tests for the runtime library
           #:make-flags
           #~(list (string-append "PREFIX=" #$output)
                   (string-append "CC=" #$(cc-for-target)))))
    (home-page "https://tree-sitter.github.io/tree-sitter/")
    (synopsis "Incremental parsing system for programming tools")
    (description
     "Tree-sitter is a parser generator tool and an incremental parsing
library.  It can build a concrete syntax tree for a source file and
efficiently update the syntax tree as the source file is edited.

Tree-sitter aims to be:

@itemize
@item General enough to parse any programming language
@item Fast enough to parse on every keystroke in a text editor
@item Robust enough to provide useful results even in the presence of syntax errors
@item Dependency-free so that the runtime library (which is written in pure C)
can be embedded in any application
@end itemize

This package includes the @code{libtree-sitter} runtime library.")
    (license license:expat)))

(define-public utf8proc-bootstrap
  (hidden-package
    (package
      (name "utf8proc-bootstrap")
      (version "2.10.0")
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/JuliaStrings/utf8proc")
               (commit (string-append "v" version))))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1n1k67x39sk8xnza4w1xkbgbvgb1g7w2a7j2qrqzqaw1lyilqsy2"))))
      (build-system gnu-build-system)
      (arguments
       `(#:tests? #f
         #:make-flags (list ,(string-append "CC=" (cc-for-target))
                            (string-append "prefix=" (assoc-ref %outputs "out")))
         #:phases
         (modify-phases %standard-phases
           (delete 'configure))))
      (home-page "https://juliastrings.github.io/utf8proc/")
      (synopsis "C library for processing UTF-8 Unicode data")
      (description "utf8proc is a small C library that provides Unicode
  normalization, case-folding, and other operations for data in the UTF-8
  encoding, supporting Unicode version 16.0.0.")
      (license license:expat))))

(define-public utf8proc
  (package
    (inherit utf8proc-bootstrap)
    (name "utf8proc")
    (version "2.10.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/JuliaStrings/utf8proc")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1n1k67x39sk8xnza4w1xkbgbvgb1g7w2a7j2qrqzqaw1lyilqsy2"))))
    (build-system gnu-build-system)
    (native-inputs
     (let ((UNICODE_VERSION "16.0.0"))  ; defined in data/Makefile
       ;; Test data that is otherwise downloaded with curl.
       `(("NormalizationTest.txt"
          ,(origin
             (method url-fetch)
             (uri (string-append "https://www.unicode.org/Public/"
                                 UNICODE_VERSION "/ucd/NormalizationTest.txt"))
             (sha256
              (base32 "1cffwlxgn6sawxb627xqaw3shnnfxq0v7cbgsld5w1z7aca9f4fq"))))
         ("GraphemeBreakTest.txt"
          ,(origin
             (method url-fetch)
             (uri (string-append "https://www.unicode.org/Public/"
                                 UNICODE_VERSION
                                 "/ucd/auxiliary/GraphemeBreakTest.txt"))
             (sha256
              (base32 "1d9w6vdfxakjpp38qjvhgvbl2qx0zv5655ph54dhdb3hs9a96azf"))))
         ("DerivedCoreProperties.txt"
          ,(origin
             (method url-fetch)
             (uri (string-append "https://www.unicode.org/Public/";
                                 UNICODE_VERSION
                                 "/ucd/DerivedCoreProperties.txt"))
             (sha256
               (base32
                 "1gfsq4vdmzi803i2s8ih7mm4fgs907kvkg88kvv9fi4my9hm3lrr"))))
         ;; For tests.
         ("perl" ,perl)
         ("ruby" ,ruby-2.7)
         ("julia" ,julia))))
    (arguments
      (substitute-keyword-arguments (package-arguments utf8proc-bootstrap)
                                    #;((#:tests? _ #f)
                                     (not (%current-target-system)))
                                    ((#:phases phases)
                                     `(modify-phases %standard-phases
                                                     (delete 'configure)
                                                     (add-before 'check 'check-data
                                                                 (lambda* (#:key inputs native-inputs #:allow-other-keys)
                                                                          (display native-inputs)
                                                                          (for-each (lambda (i)
                                                                                      (copy-file (assoc-ref (or native-inputs inputs) i)
                                                                                                 (string-append "data/" i)))
                                                                                    '("NormalizationTest.txt" "GraphemeBreakTest.txt"
                                                                                      "DerivedCoreProperties.txt"))))))))
    (properties (alist-delete 'hidden? (package-properties
                                         utf8proc-bootstrap)))))

(define-public neovim
  (package
    (name "neovim")
    (version "0.11.0")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/neovim/neovim")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1z7xmngjr93dc52k8d3r6x0ivznpa8jbdrw24gqm16lg9gzvma02"))))
    (build-system cmake-build-system)
    (arguments
     (list #:modules
           '((srfi srfi-26) (guix build cmake-build-system)
             (guix build utils))
           #:tests? #f
           #:configure-flags
           #~(list #$@(if (member (if (%current-target-system)
                                      (gnu-triplet->nix-system (%current-target-system))
                                      (%current-system))
                                  (package-supported-systems luajit))
                          '()
                          '("-DPREFER_LUA:BOOL=YES")))
           #:phases
           #~(modify-phases %standard-phases
               (add-after 'unpack 'set-lua-paths
                 (lambda* _
                   (let* ((lua-version "5.1")
                          (lua-cpath-spec (lambda (prefix)
                                            (let ((path (string-append
                                                         prefix
                                                         "/lib/lua/"
                                                         lua-version)))
                                              (string-append
                                               path
                                               "/?.so;"
                                               path
                                               "/?/?.so"))))
                          (lua-path-spec (lambda (prefix)
                                           (let ((path (string-append prefix
                                                        "/share/lua/"
                                                        lua-version)))
                                             (string-append path "/?.lua;"
                                                            path "/?/?.lua"))))
                          (lua-inputs (list (or #$(this-package-input "lua")
                                                #$(this-package-input "luajit"))
                                            #$lua5.1-luv
                                            #$lua5.1-lpeg
                                            #$lua5.1-bitop
                                            #$lua5.1-libmpack)))
                     (setenv "LUA_PATH"
                             (string-join (map lua-path-spec lua-inputs) ";"))
                     (setenv "LUA_CPATH"
                             (string-join (map lua-cpath-spec lua-inputs) ";"))
                     #t)))
               (add-after 'unpack 'prevent-embedding-gcc-store-path
                 (lambda _
                   ;; nvim remembers its build options, including the compiler with
                   ;; its complete path.  This adds gcc to the closure of nvim, which
                   ;; doubles its size.  We remove the reference here.
                   (substitute* "cmake.config/versiondef.h.in"
                     (("\\$\\{CMAKE_C_COMPILER\\}") "/gnu/store/.../bin/gcc"))
                   #t)))))
    (inputs (list libuv-for-luv
                  msgpack
                  libtermkey
                  libvterm
                  unibilium
                  utf8proc
                  jemalloc
                  (if (member (if (%current-target-system)
                                  (gnu-triplet->nix-system (%current-target-system))
                                  (%current-system))
                              (package-supported-systems luajit))
                      luajit
                      lua-5.1)
                  lua5.1-luv
                  lua5.1-lpeg
                  lua5.1-bitop
                  lua5.1-libmpack
                  tree-sitter))
    (native-inputs (list pkg-config gettext-minimal gperf))
    (home-page "https://neovim.io")
    (synopsis "Fork of vim focused on extensibility and agility")
    (description
     "Neovim is a project that seeks to aggressively
refactor Vim in order to:

@itemize
@item Simplify maintenance and encourage contributions
@item Split the work between multiple developers
@item Enable advanced external UIs without modifications to the core
@item Improve extensibility with a new plugin architecture
@end itemize
")
    ;; Neovim is licensed under the terms of the Apache 2.0 license,
    ;; except for parts that were contributed under the Vim license.
    (license (list license:asl2.0 license:vim))))

(define-public nvim-telescope-fzf-native
  (let ((commit "2a5ceff981501cff8f46871d5402cd3378a8ab6a")
        (revision "0"))
  (package
   (name "nvim-telescope-fzf-native")
   (version (git-version "0.0.0" revision commit))
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/nvim-telescope/telescope-fzf-native.nvim")
                  (commit commit)))
            (file-name (git-file-name name version))
            (sha256
             (base32
              "0n5yaslwmjn2057njyn604wb60zhqgad439zxaafd7qmvyjazlfi"))))
   (build-system gnu-build-system)
   (arguments
    (list
     #:phases
     #~(modify-phases %standard-phases
                      (delete 'configure)
                      (delete 'install-locale)
                      (delete 'check)
                      (replace 'build
                               (lambda _
                                 (invoke "make" "CC=gcc")))
                      (replace 'install
                               (lambda _
                                 (mkdir-p "share/lib")
                                 (install-file "build/libfzf.so" (string-append #$output "/share/lib")))))))
   (synopsis "")
   (description "")
   (home-page "")
   (license license:expat))))
