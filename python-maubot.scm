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
  #:use-module (gnu packages check)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module (guix licenses))

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
   (native-inputs
    `(("python-pytest" ,python-pytest)))
   (arguments
    `(#:phases (modify-phases %standard-phases
			      (replace 'check
				       (lambda _
					 ;; Extend PYTHONPATH so the built package will be found.
					 (setenv "PYTHONPATH"
						 (string-append (getcwd) "/build/lib:"
								(getenv "PYTHONPATH")))
					 ;; (invoke "python" "-m" "pytest")
					 ;; (invoke "pytest" "-p" "no:logging")
					 #t)))))

   (home-page "https://github.com/maubot/maubot")
   (synopsis "A plugin-based Matrix bot system.")
   (description "A plugin-based Matrix bot system.")
   (license gpl3+)))


(define-public python-mautrix
(package
 (name "python-mautrix")
 (version "0.10.4")
 (source
  (origin
   (method url-fetch)
   (uri (pypi-uri "mautrix" version))
   (sha256
    (base32
     "0sdq333895r7qvw40zgysw8msnjx5b0y9y08nhwra22nxcllxg7z"))))
 (build-system python-build-system)
 (propagated-inputs
  `(("python-aiohttp" ,python-aiohttp)
    ("python-attrs" ,python-attrs)
    ("python-yarl" ,python-yarl)))
 (native-inputs
  `(("python-pytest" ,python-pytest)))
 (arguments
  `(#:phases (modify-phases %standard-phases
			    (replace 'check
				     (lambda _
				       ;; Extend PYTHONPATH so the built package will be found.
				       (setenv "PYTHONPATH"
					       (string-append (getcwd) "/build/lib:"
							      (getenv "PYTHONPATH")))
				       (invoke "python" "-m" "pytest")
				       ;; (invoke "pytest" "-p" "no:logging")
				       #t)))))
 (home-page "https://github.com/mautrix/python")
 (synopsis "A Python 3 asyncio Matrix framework.")
 (description
  "A Python 3 asyncio Matrix framework.")
 (license gpl3+)))

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
    `(("python-prompt-toolkit" ,python-prompt-toolkit)
      ("python-pygments" ,python-pygments)
      ("python-regex" ,python-regex)))
   (arguments
    `(#:tests? #f))
   (home-page "https://github.com/CITGuru/PyInquirer/")
   (synopsis
    "A Python module for collection of common interactive command line user interfaces, based on Inquirer.js")
   (description
    "A Python module for collection of common interactive command line user interfaces, based on Inquirer.js")
   (license expat)))

python-maubot