(define-module (python-maubot)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages python-compression)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages sphinx)
  #:use-module (gnu packages check)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:))

(define-public python-maubot
  (package
   (name "python-maubot")
   (version "0.1.2")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "maubot" version))
     (sha256
      (base32
       "0bv70pxl3d15kxnmsxlkbacf97q2kb7av5a080jc70xqj19vmjjy"))))
   (build-system python-build-system)
   (propagated-inputs
    `(("python-aiohttp" ,python-aiohttp)
      ("python" ,python)
      ("python-pytest" ,python-pytest)
      ("python-alembic" ,python-alembic)
      ("python-attrs" ,python-attrs)
      ("python-bcrypt" ,python-bcrypt)
      ("python-click" ,python-click)
      ("python-colorama" ,python-colorama)
      ("python-commonmark" ,python-commonmark)
      ("python-jinja2" ,python-jinja2)
      ("python-mautrix" ,python-mautrix)
      ("python-packaging" ,python-packaging)
      ("python-pyinquirer" ,python-pyinquirer)
      ("python-ruamel.yaml" ,python-ruamel.yaml)
      ("python-sqlalchemy" ,python-sqlalchemy)
      ("python-yarl" ,python-yarl)))
   ;; (native-inputs
   ;; `(("python-pytest" ,python-pytest)))
   (arguments
    ;; `(#:tests? #f))
    `(#:phases (modify-phases %standard-phases
			      (replace 'check
				       (lambda _
					 ;; 					 ;; Extend PYTHONPATH so the built package will be found.
					 (setenv "PYTHONPATH"
						 (string-append (getcwd) "/build/lib:"
								(getenv "PYTHONPATH")))
					 ;; (invoke "python" "-m" "pytest")
					 ;; (invoke "pytest" "-p" "no:logging")
					 #t)))))
   (home-page "https://github.com/maubot/maubot")
   (synopsis "A plugin-based Matrix bot system.")
   (description "A plugin-based Matrix bot system.")
   (license license:gpl3+)))


(define-public python-mautrix
  (package
   (name "python-mautrix")
   (version "0.11.4")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "mautrix" version))
     (sha256
      (base32
       "047k1xk34hhdbnza8vapxzv51mnw8m5xgdhjkvf3jkc0gki5g2y5"))))
   (build-system python-build-system)
   (propagated-inputs
    `(("python-aiohttp" ,python-aiohttp)
      ("python-attrs" ,python-attrs)
      ("python-yarl" ,python-yarl)))
   (native-inputs
    `(("python-pytest" ,python-pytest)))
   (arguments
    `(#:phases
      (modify-phases %standard-phases
		     (replace 'check
			      (lambda _
				;; Extend PYTHONPATH so the built package will be found.
				(setenv "PYTHONPATH"
					(string-append (getcwd) "/build/lib:"
						       (getenv "PYTHONPATH")))
				(invoke "python" "-m" "pytest")
				;; (invoke "pytest" "-p" "no:logging")
				#t))
		     (add-after 'unpack 'patch-requirements
				(lambda _
				  (substitute* "requirements.txt"
					       (("0.24") "0.25")))))))
   (home-page "https://github.com/mautrix/python")
   (synopsis "A Python 3 asyncio Matrix framework.")
   (description
    "A Python 3 asyncio Matrix framework.")
   (license license:gpl3+)))

(define-public python-pyinquirer
(package
 (name "python-pyinquirer")
 (version "1.0.3")
 (source
  (origin
   (method url-fetch)
   (uri (pypi-uri "PyInquirer" version))
   (sha256
    (base32
     "0lgfdlv0vabbhfzmrgqiq9fkwxz9v67w023rda4bszvjsxl2vaf9"))))
 (build-system python-build-system)
 (propagated-inputs
  `(("python-prompt-toolkit-1" ,python-prompt-toolkit-1)
    ("python-pygments" ,python-pygments)
    ("python-regex" ,python-regex)))
 (arguments
  `(#:tests? #f))
 (home-page "https://github.com/CITGuru/PyInquirer/")
 (synopsis
  "A Python module for collection of common interactive command line user interfaces, based on Inquirer.js")
 (description
  "A Python module for collection of common interactive command line user interfaces, based on Inquirer.js")
 (license license:expat)))

(define-public python-prompt-toolkit-1
  (package (inherit python-prompt-toolkit-2)
	   (name "python-prompt-toolkit-1")
	   (version "1.0.14")
	   (source
	    (origin
	     (method url-fetch)
	     (uri (pypi-uri "prompt_toolkit" version ".tar.gz"))
	     (sha256
              (base32
	       "0bv249ni511lqwjbg6yrvxnv0h76axfx3wnrflb045sb3cxl2rnc"))))))

(define-public python2-prompt-toolkit-1
  (package-with-python2 python-prompt-toolkit-1))

(define-public python-mautrix-signal
  (package
   (name "python-mautrix-signal")
   (version "0.2.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "mautrix-signal" version))
     (sha256
      (base32 "07y4z27idamr3w17v5d2pbvlkwnxbl5rciyyiygwacp0zqi1hy57"))))
   (build-system python-build-system)
   (propagated-inputs
    `(("python-aiohttp" ,python-aiohttp)
      ("python-asyncpg" ,python-asyncpg)
      ("python-attrs" ,python-attrs)
      ("python-commonmark" ,python-commonmark)
      ("python-magic" ,python-magic)
      ("python-mautrix" ,python-mautrix)
      ("python-ruamel.yaml" ,python-ruamel.yaml)
      ("python-yarl" ,python-yarl)))
   (home-page "https://github.com/mautrix/signal")
   (synopsis "A Matrix-Signal puppeting bridge.")
   (description "A Matrix-Signal puppeting bridge.")
   (license license:agpl3+)))

(define-public python-sphinxcontrib-asyncio
  (package
   (name "python-sphinxcontrib-asyncio")
   (version "0.3.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "sphinxcontrib-asyncio" version))
     (sha256
      (base32 "0bkj010ygsr7m769llf2aq4bbjfhdwqrrabi98j8gpvyzvh2dzcr"))))
   (build-system python-build-system)
   (arguments
    ;; No test-suite is present see:
    ;; https://github.com/aio-libs/sphinxcontrib-asyncio/issues/9
    `(#:tests? #f))
   (propagated-inputs
    `(("python-sphinx" ,python-sphinx)))
   (home-page "https://github.com/aio-libs/sphinxcontrib-asyncio")
   (synopsis "sphinx extension to support coroutines in markup")
   (description "sphinx extension to support coroutines in markup")
   (license license:asl2.0)))

(define-public python-asyncpg
  (package
   (name "python-asyncpg")
   (version "0.25.0")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "asyncpg" version))
     (sha256
      (base32 "0h1573lp4607nppflnnjrhn7yrfy6i54cm98gi4qbcikjykfdy33"))))
   (build-system python-build-system)
   (propagated-inputs
    `(("python-typing-extensions" ,python-typing-extensions)))
   (native-inputs
    `(("postgresql" ,postgresql)
      ("python-cython" ,python-cython)
      ("python-flake8" ,python-flake8)
      ("python-pycodestyle" ,python-pycodestyle)
      ("python-pytest" ,python-pytest)
      ("python-sphinx" ,python-sphinx)
      ("python-sphinx-rtd-theme" ,python-sphinx-rtd-theme)
      ("python-sphinxcontrib-asyncio" ,python-sphinxcontrib-asyncio)
      ("python-uvloop" ,python-uvloop)))
   (home-page "https://github.com/MagicStack/asyncpg")
   (synopsis "An asyncio PostgreSQL driver")
   (description "An asyncio PostgreSQL driver")
   (license license:asl2.0)))
