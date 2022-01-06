(define-module (python-maubot)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-check)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:))


(define-public python-stdiomask
  (package
   (name "python-stdiomask")
   (version "0.0.6")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "stdiomask" version))
     (sha256
      (base32 "19m3p6i7fj7nmkbsjhiha3f2l7d05j9gf9ha2pd0pqfrx9lp1r61"))))
   (build-system python-build-system)
   (arguments
    `(#:tests? #f))
   (home-page "https://github.com/asweigart/stdiomask")
   (synopsis
    "A cross-platform Python module for entering passwords to a stdio terminal and displaying a **** mask, which getpass cannot do.")
   (description
    "This package provides a cross-platform Python module for entering passwords to a
stdio terminal and displaying a **** mask, which getpass cannot do.")
   (license #f)))

(define-public python-pysimplevalidate
  (package
   (name "python-pysimplevalidate")
   (version "0.2.12")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "PySimpleValidate" version))
     (sha256
      (base32 "06dapa53pjyjbrfafay0l25ni88sbjys0flgcm04rb8prayj8pb4"))))
   (build-system python-build-system)
   (arguments
    `(#:tests? #f))
   (home-page "https://github.com/asweigart/pysimplevalidate")
   (synopsis
    "A collection of string-based validation functions, suitable for use in other Python 2 and 3 applications.")
   (description
    "This package provides a collection of string-based validation functions,
suitable for use in other Python 2 and 3 applications.")
   (license license:bsd-3)))

(define-public python-pyinputplus
  (package
   (name "python-pyinputplus")
   (version "0.2.12")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "PyInputPlus" version))
     (sha256
      (base32 "0cb2a00msvzyr0s3pcd3lqa6xbyar9sx2yk2vk3zw0yhqqyv11is"))))
   (build-system python-build-system)
   (arguments
    `(#:tests? #f))
   (propagated-inputs (list python-pysimplevalidate python-stdiomask))
   (home-page "https://github.com/asweigart/pyinputplus")
   (synopsis "Provides more featureful versions of input() and raw_input().")
   (description
    "This package provides more featureful versions of input() and raw_input().")
   (license license:bsd-3)))


python-pyinputplus
