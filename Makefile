SPHINXOPTS    	?=
SPHINXBUILD   	?= sphinx-build
SOURCEDIR     	= .
BUILDDIR      	= _build

VENV_DIR	  	= ${BUILDDIR}/venv
VENV_ACTIVATE   = ${VENV_DIR}/bin/activate
PYTHON			= ${VENV_DIR}/bin/python3

# I have tried using `.ONESHELL:` to share virtual env between targets
# it worked nicely for standard stuff, but was not working with Sphinx
# So please, activate manually.

.PHONY: help
help: venv
	. $(VENV_ACTIVATE) ; $(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: setup
setup: venv
	. $(VENV_DIR)/bin/activate ; which pip
	which pip3
	$(VENV_DIR)/bin/activate && which pip3
	which $(SPHINXBUILD)

.PHONY: venv
venv: $(VENV_DIR)/bin/activate

requirements.txt:
	touch requirements.txt

$(VENV_DIR)/bin/activate: requirements.txt
	test -d $(VENV_DIR) || virtualenv -p python3 $(VENV_DIR)
	${PYTHON} -m pip install -U pip
	${PYTHON} -m pip install -Ur requirements.txt
	touch $(VENV_DIR)/bin/activate

.PHONY: clean
clean:
	rm -rf "$(BUILDDIR)"
	rm -f changelog.md

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
.PHONY: Makefile
%: Makefile venv
	. $(VENV_ACTIVATE) ; $(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
# 	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: changelog
changelog: bundle changelog.md

bundle:
	bundle install

changelog.md:
	bundle exec bin/generate_handbook_changelog
