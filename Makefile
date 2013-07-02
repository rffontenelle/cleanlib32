SHELL = /bin/bash
INSTALL = /bin/install -c
MSGFMT = /usr/bin/msgfmt
SED = /bin/sed
DESTDIR =
bindir = /usr/bin
sysconfdir = /etc
mandir = /usr/share/man/man1
localedir = /usr/share/locale

all:

install: all
	${INSTALL} -d $(DESTDIR)/${bindir}
	${INSTALL} -m 755 cleanlib32 $(DESTDIR)/${bindir}

