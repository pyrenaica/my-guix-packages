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
