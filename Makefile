PROJECT_NAME := auto-wg
EXE_NAME := run.sh
PLIST_NAME := info.hotoku.$(PROJECT_NAME)
PLIST_DESTPATH := $(HOME)/Library/LaunchAgents
LOGCONF_FILE := $(PROJECT_NAME).conf
LOGCONF_DEST := /etc/newsyslog.d/$(LOGCONF_FILE)


.PHONY: all
all: load run $(LOGCONF_DEST)
	@echo making $@


.PHONY: clean
clean: unload
	@echo making $@
	rm -f $(PLIST_NAME).plist $(LOGCONF_FILE)
	sudo rm -f $(LOGCONF_DEST)


.PHONY: load
load: $(PLIST_NAME).plist unload permission
	@echo making $@
	cp -f $(PLIST_NAME).plist $(PLIST_DESTPATH)
	launchctl load $(PLIST_DESTPATH)/$(PLIST_NAME).plist


.PHONY: unload
unload:
	@echo making $@
	launchctl unload $(PLIST_DESTPATH)/$(PLIST_NAME).plist || true
	rm -f $(PLIST_DESTPATH)/$(PLIST_NAME).plist


.PHONY: permission
permission: $(EXE_NAME)
	chmod 755 $(EXE_NAME)


$(PLIST_NAME).plist: $(PLIST_NAME).jinja.plist
	@echo making $@
	jinja2 \
		-D WORKDIR=$(PWD) \
		-D PLIST_NAME=$(PLIST_NAME) $< > $@


$(LOGCONF_DEST): $(PROJECT_NAME).jinja.conf
	@echo making $@
	jinja2 \
		-D PWD=$(PWD) $< > $(LOGCONF_FILE)
	sudo cp $(LOGCONF_FILE) $@
