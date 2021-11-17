(define-module (ls-python-gallery-dl)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages check)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:))

(define-public python-gallery-dl
  (package
   (name "python-gallery-dl")
   (version "1.18.4")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "gallery-dl" version))
     (sha256
      (base32 "1jfsq27szz4vy5iaapxxk41mckmga664riqixvi7z1nyzl34gf5x"))))
   (build-system python-build-system)
   (propagated-inputs `(("python-requests" ,python-requests)))
   (home-page "https://github.com/mikf/gallery-dl")
   (synopsis
    "Command-line program to download image galleries and collections from several image hosting sites")
   (description
    "Command-line program to download image galleries and collections from several image hosting sites")
   (license license:gpl2+)))

python-gallery-dl
