(define-module (python-pyinputplus)
  #:use-module (gnu packages python)
  #:use-module (gnu packages video)
  #:use-module (gnu packages music)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages check)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages compression)
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

(define-public python-hashid
  (package
   (name "python-hashid")
   (version "3.1.4")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "hashID" version ".zip"))
     (sha256
      (base32 "1iv3ylnli8b62m6jyh7w5qqlk926dnwprwcqcbykjlg99167z3xg"))))
   (build-system python-build-system)
   (native-inputs (list unzip))
   (home-page "https://github.com/psypanda/hashID")
   (synopsis "Software to identify the different types of hashes")
   (description "Software to identify the different types of hashes")
   (license license:gpl3+)))

(define-public ls-yt-dlp
  (package/inherit youtube-dl
		   (name "yt-dlp")
		   (version "2022.02.04")
		   (source (origin
			    (method url-fetch)
			    (uri (string-append "https://github.com/yt-dlp/yt-dlp/"
						"releases/download/"
						version "/yt-dlp.tar.gz"))
			    (sha256
			     (base32
			      "1qx8sx47lzyrcl00r2657zjaq0mwfbzjyfnv5lr5dlm552f13pf8"))
			    (snippet
			     '(begin
				;; Delete the pre-generated files, except for the man page
				;; which requires 'pandoc' to build.
				(for-each delete-file '("yt-dlp"
							;;pandoc is needed to generate
							;;"yt-dlp.1"
							"completions/bash/yt-dlp"
							"completions/fish/yt-dlp.fish"
							"completions/zsh/_yt-dlp"))
				#t))))
		   (arguments
		    (substitute-keyword-arguments (package-arguments youtube-dl)
						  ((#:tests? _) #t)
						  ((#:phases phases)
						   `(modify-phases ,phases
								   ;; See the comment for the corresponding phase in youtube-dl.
								   (replace 'default-to-the-ffmpeg-input
									    (lambda _
									      (substitute* "yt_dlp/postprocessor/ffmpeg.py"
											   (("\\.get_param\\('ffmpeg_location'\\)" match)
											    (format #f "~a or '~a'" match (which "ffmpeg"))))
									      #t))
								   (replace 'build-generated-files
									    (lambda _
									      ;; Avoid the yt-dlp.1 target, which requires pandoc.
									      (invoke "make" "PYTHON=python" "yt-dlp" "completions")))
								   (replace 'fix-the-data-directories
									    (lambda* (#:key outputs #:allow-other-keys)
									      (let ((prefix (assoc-ref outputs "out")))
										(substitute* "setup.py"
											     (("'etc/")
											      (string-append "'" prefix "/etc/"))
											     (("'share/")
											      (string-append "'" prefix "/share/"))))
									      #t))
								   (delete 'install-completion)
								   (replace 'check
									    (lambda* (#:key tests? #:allow-other-keys)
									      (when tests?
										(invoke "pytest" "-k" "not download"))))))))
		   (inputs
		    `(("python-mutagen" ,python-mutagen)
		      ("python-pycryptodomex" ,python-pycryptodomex)
		      ("python-websockets" ,python-websockets)
		      ,@(package-inputs youtube-dl)))
		   (native-inputs
		    `(("python-pytest" ,python-pytest)
		      ,@(package-native-inputs youtube-dl)))
		   (description
		    "yt-dlp is a small command-line program to download videos from
YouTube.com and many more sites.  It is a fork of youtube-dl with a
focus on adding new features while keeping up-to-date with the
original project.")
		   (properties '((release-monitoring-url . "https://pypi.org/project/yt-dlp/")))
		   (home-page "https://github.com/yt-dlp/yt-dlp")))

