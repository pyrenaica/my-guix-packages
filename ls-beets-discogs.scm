(define-module (ls-beets-discogs)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages time)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:))

(define-public ls-beets
  (package
    (name "ls-beets")
    (version "1.5.0")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "beets" version))
              (sha256
               (base32
                "0arl4nc3y8iwa331hf6ggai19y8ns9pl03g5d6ac857wq2x7nzw8"))))
    (build-system python-build-system)
    (arguments
     `(#:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'set-HOME
           (lambda _
             (setenv "HOME" (string-append (getcwd) "/tmp"))
             #t))
         (replace 'check
           (lambda* (#:key tests? #:allow-other-keys)
             (when tests?
               (invoke "pytest" "-v" "test"))))
         ;; Wrap the executable, so it can find python-gi (aka
         ;; pygobject) and gstreamer plugins.
         (add-after 'wrap 'wrap-typelib
           (lambda* (#:key outputs #:allow-other-keys)
             (let ((prog (string-append (assoc-ref outputs "out")
                                        "/bin/beet"))
                   (plugins (getenv "GST_PLUGIN_SYSTEM_PATH"))
                   (types (getenv "GI_TYPELIB_PATH")))
               (wrap-program prog
                 `("GST_PLUGIN_SYSTEM_PATH" ":" prefix (,plugins))
                 `("GI_TYPELIB_PATH" ":" prefix (,types)))
               #t))))))
    (native-inputs
     `(("gobject-introspection" ,gobject-introspection)
       ("python-flask" ,python-flask)
       ("python-mock" ,python-mock)
       ("python-py7zr" ,python-py7zr)
       ("python-pytest" ,python-pytest-6)
       ("python-responses" ,python-responses)))
    (inputs
     `(("bash-minimal" ,bash-minimal)
       ("gst-plugins-base" ,gst-plugins-base)
       ("gst-plugins-good" ,gst-plugins-good)
       ("gstreamer" ,gstreamer)
       ("python-confuse" ,python-confuse)
       ("python-jellyfish" ,python-jellyfish)
       ("python-mediafile" ,python-mediafile)
       ("python-munkres" ,python-munkres)
       ("python-musicbrainzngs" ,python-musicbrainzngs)
       ("python-pyyaml" ,python-pyyaml)
       ("python-six" ,python-six)
       ("python-unidecode" ,python-unidecode)
       ;; Optional dependencies for plugins. Some of these are also required by tests.
       ("python-beautifulsoup4" ,python-beautifulsoup4) ; For lyrics.
       ("python-discogs-client" ,python-discogs-client) ; For discogs.
       ("python-mpd2" ,python-mpd2) ; For mpdstats.
       ("python-mutagen" ,python-mutagen) ; For scrub.
       ("python-langdetect" ,python-langdetect) ; For lyrics.
       ("python-pillow" ,python-pillow) ; For fetchart, embedart, thumbnails.
       ("python-pyacoustid" ,python-pyacoustid) ; For chroma.
       ("python-pygobject" ,python-pygobject) ; For bpd, replaygain.
       ("python-pylast" ,python-pylast) ; For lastgenre, lastimport.
       ("python-pyxdg" ,python-pyxdg) ; For thumbnails.
       ("python-rarfile" ,python-rarfile) ; For import.
       ("python-reflink" ,python-reflink) ; For reflink.
       ("python-requests" ,python-requests)
       ("python-requests-oauthlib" ,python-requests-oauthlib) ; For beatport.
       ("ls-python-pycountry" ,ls-python-pycountry)))
    (home-page "https://beets.io")
    (synopsis "Music organizer")
    (description "The purpose of beets is to get your music collection
right once and for all.  It catalogs your collection, automatically
improving its metadata as it goes using the MusicBrainz database.
Then it provides a variety of tools for manipulating and accessing
your music.")
    (license license:expat)))

(define-public ls-beets-discogs
  (package
    (name "ls-beets-discogs")
    (version "2.3.12")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "python3-discogs-client" version))
        (sha256
          (base32
            "1zmib0i9jicv9fyphgkcrk418qmpv3l4p38ibl31sh237ki5xqw9"))))
    (build-system python-build-system)
    (propagated-inputs
      `(("python-dateutil" ,python-dateutil)
        ("python-oauthlib" ,python-oauthlib)
        ("python-requests" ,python-requests)))
    (home-page
      "https://github.com/joalla/discogs_client")
    (synopsis "Python API client for Discogs")
    (description "Python API client for Discogs")
    (license license:expat)))

(define-public ls-python-beetcamp
  (package
    (name "ls-python-beetcamp")
    (version "0.10.1")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "beetcamp" version))
        (sha256
          (base32
            "17x2h8v9pjq1q124x9rlvarbi7yn5lh3621dzsh4h2m6ml71p2zg"))))
    (build-system python-build-system)
    (propagated-inputs
      `(("python-cached-property" ,python-cached-property)
        ("ls-python-pycountry" ,ls-python-pycountry)
        ("python-requests" ,python-requests)))
    (home-page "https://github.com/snejus/beetcamp")
    (synopsis
      "Bandcamp autotagger source for beets (http://beets.io).")
    (description
     "Bandcamp autotagger source for beets (http://beets.io).
Beetcamp is an up-to-date fork of beets-bandcamp")
    (license license:gpl2+)))

(define-public ls-python-pycountry
  (package
    (name "ls-python-pycountry")
    (version "20.7.3")
    (source
      (origin
        (method url-fetch)
        (uri (pypi-uri "pycountry" version))
        (sha256
          (base32
            "0hnbabsmqimx5hqh0jbd2f64i8fhzhhbrvid57048hs5sd9ll241"))))
    (build-system python-build-system)
    (home-page "")
    (synopsis
      "ISO country, subdivision, language, currency and script definitions and their translations")
    (description
      "ISO country, subdivision, language, currency and script definitions and their translations")
    (license license:lgpl2.1+)))
