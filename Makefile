# Makefile for cleanlib32
#

PROGVERSION=0.2

# You can set these variables from the command line.
bindir = /usr/bin
datadir = /usr/share/
SHELL=/bin/bash
INSTALL = /bin/install -c
LOCALE_DIR=locale
DOMAIN=cleanlib32
CHARSET=UTF-8
# set language codes in here
LOCALES=pt_BR

# Internal variables.
template=$(LOCALE_DIR)/$(DOMAIN).pot

# Phony targets.
.PHONY : help pot rmpot mo srctarball install

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  pot            to make the PO Template file $(DOMAIN).pot"
	@echo "  mo             to update the PO files from POT and build binary MO files"
	@echo "  rmpot          to remove the PO Template file $(DOMAIN).pot"
	@echo "  install        to install the files in the desire folder. DESTDIR recommended"

# Make the PO Template file. In order to update the POT file, the file needs
# to be removed with `make rmpot' first.
template:
	@xgettext --language=Shell \
	  --from-code=UTF-8 \
	  --copyright-holder="josephgbr <rafael.f.f1 at gmail.com>" \
	  --msgid-bugs-address="rafael.f.f1@gmail.com" \
	  --package-name="cleanlib32" \
	  --no-wrap \
	  --sort-by-file \
	  --output=$(template) cleanlib32.in
	@sed --in-place "$(template)" --expression=s/"SOME DESCRIPTIVE TITLE."/"Translation file for the cleanlib32 package."/
	@sed --in-place "$(template)" --expression=s/PACKAGE/cleanlib32/
	@sed --in-place "$(template)" --expression=s/"Copyright (C) YEAR"/"Copyright (C) 2012-2013"/
	@sed --in-place "$(template)" --expression=s/CHARSET/$(CHARSET)/
	@sed --in-place "$(template)" --expression=s/"Language: "/"Language: en"/
	@sed --in-place "$(template)" --expression=s/"Project-Id-Version:.*"/"Project-Id-Version: ${DOMAIN} ${PROGVERSION}\\\n\""/
	@echo
	@echo "Build finished. The PO Template file: $(template)"

# Make POT file.
pot: template

# Remove POT file.
rmpot:
	@rm -i $(template)

# Update the PO files from the template and build binary MO file for each locale.
mo: template make-po.sh
	@./make-po.sh
	@rm make-po.sh

make-po.sh:
	@cp scripts/make-po.sh.in make-po.sh
	@sed --in-place make-po.sh --expression=s/LOCALES/"$(LOCALES)"/
	@sed --in-place make-po.sh --expression=s/LOCALE_DIR/$(LOCALE_DIR)/
	@sed --in-place make-po.sh --expression=s/TEMPLATE/$(LOCALE_DIR)\\/$(DOMAIN).pot/
	@sed --in-place make-po.sh --expression=s/DOMAIN/$(DOMAIN)/
	@chmod +x make-po.sh
	
srctarball:
	@cp scripts/make-tarball.sh.in make-tarball.sh
	@chmod +x make-tarball.sh
	./make-tarball.sh
	rm make-tarball.sh

install: mo
	${INSTALL} -d ${DESTDIR}${bindir} $(DESTDIR)${datadir}
	${INSTALL} -m 755 cleanlib32.in ${DESTDIR}${bindir}/cleanlib32
	for locale in $(LOCALES) ; do \
      cp --parents -R $(LOCALE_DIR)/$$locale/LC_MESSAGES/cleanlib32.mo $(DESTDIR)${datadir}; \
	done

