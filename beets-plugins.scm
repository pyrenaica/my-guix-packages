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
  #:use-module (guix licenses))



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
    (license expat)))
