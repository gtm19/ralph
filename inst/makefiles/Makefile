# h/t to @jimhester and @yihui for this parse block:
# https://github.com/yihui/knitr/blob/dc5ead7bcfc0ebd2789fe99c527c7d91afb3de4a/Makefile#L1-L4
# Note the portability change as suggested in the manual:
# https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Writing-portable-packages
PKGNAME = `sed -n "s/Package: *\([^ ]*\)/\1/p" DESCRIPTION`
PKGVERS = `sed -n "s/Version: *\([^ ]*\)/\1/p" DESCRIPTION`

all: check

build:
	R CMD build .

check: document build
	Rscript \
	-e 'if (!requireNamespace("rcmdcheck")) install.packages("rcmdcheck")' \
	-e 'rcmdcheck::rcmdcheck(args = "--no-manual", error_on = "error")'

install_deps:
	Rscript \
	-e 'if (dir.exists("renv")) {' \
	-e 'if (!requireNamespace("renv")) install.packages("renv")' \
	-e 'renv::install()' \
	-e '} else {' \
	-e 'if (!requireNamespace("remotes")) install.packages("remotes")' \
	-e 'remotes::install_deps(dependencies = TRUE)' \
	-e '}' \

document: readme
	Rscript \
	-e 'devtools::document(".")'

install: install_deps build
	R CMD INSTALL $(PKGNAME)_$(PKGVERS).tar.gz

clean:
	@rm -rf $(PKGNAME)_$(PKGVERS).tar.gz $(PKGNAME).Rcheck

readme: README.md

README.md: README.Rmd
	Rscript \
	-e 'if (!requireNamespace("knitr")) install.packages("knitr")' \
	-e 'knitr::knit("$<", output = "$@")'
	