# h/t to @jimhester and @yihui for this parse block:
# https://github.com/yihui/knitr/blob/dc5ead7bcfc0ebd2789fe99c527c7d91afb3de4a/Makefile#L1-L4
# Note the portability change as suggested in the manual:
# https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Writing-portable-packages
PKGNAME = `sed -n "s/Package: *\([^ ]*\)/\1/p" DESCRIPTION`
PKGVERS = `sed -n "s/Version: *\([^ ]*\)/\1/p" DESCRIPTION`

#### variables
USER = user # Github username preferably
TAG = latest

IMAGE_TAG = ${USER}/${PKGNAME}:${TAG}
CONTAINER_NAME = ${PKGNAME}_CTR

DOCKER_USER = rstudio
DOCKER_PASS = CHANGEME
DOCKER_UID = $(shell id -u)
DOCKER_GID = $(shell id -g)

RSTUDIO_PORT = 8787

#### Build targets
RMD_FILES  := $(wildcard *.Rmd)
RMD_KNIT := $(patsubst %.Rmd, knit-%, $(RMD_FILES))
HTML_FILES := $(patsubst %.Rmd, %.html, $(RMD_FILES))
MD_FILES := $(patsubst %.Rmd, %.md, $(RMD_FILES))

#### R / package stuff
all: check

build: install_deps
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

install: build
	R CMD INSTALL $(PKGNAME)_$(PKGVERS).tar.gz

clean:
	@rm -rf $(PKGNAME)_$(PKGVERS).tar.gz $(PKGNAME).Rcheck

#### Knitting
%.md %.html: %.Rmd
	Rscript \
	-e 'if (!requireNamespace("rmarkdown")) install.packages("rmarkdown")' \
	-e "rmarkdown::render(input = '$<', output_file = '$@')"

knit-%: %.Rmd
	Rscript \
	-e 'if (!requireNamespace("rmarkdown")) install.packages("rmarkdown")' \
	-e "rmarkdown::render(input = '$<', output_format = 'all')"

unknit-%:
	rm -f $*.html \
	rm -f $*.md

knit: $(RMD_KNIT)
knit-md: $(MD_FILES)
knit-html: $(HTML_FILES)

readme: knit-README
