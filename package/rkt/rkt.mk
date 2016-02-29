RKT_VERSION = 1ddc36601c8688ff207210bc9ecbf973d09573fa
RKT_SITE = https://github.com/coreos/rkt.git
RKT_SITE_METHOD = git
RKT_DEPENDENCIES = acl cpio golang systemd squashfs

RKT_BUILD_DIR = build-rkt-1.0.0
RKT_STAGE1_DEFAULT_DIR = /usr/share/rkt
RKT_AUTORECONF = YES
RKT_CONF_OPTS = --enable-tpm=auto \
				--with-stage1-flavors=host \
				--with-stage1-default-images-directory=$(RKT_STAGE1_DEFAULT_DIR) \
				--with-stage1-default-location=$(RKT_STAGE1_DEFAULT_DIR)/stage1-host.aci

define RKT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/$(RKT_BUILD_DIR)/bin/rkt $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/$(RKT_BUILD_DIR)/bin/actool $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/$(RKT_BUILD_DIR)/bin/*.aci $(TARGET_DIR)$(RKT_STAGE1_DEFAULT_DIR)
	$(INSTALL) -D -m 0644 $(@D)/dist/init/systemd/*.service $(TARGET_DIR)/usr/lib/systemd/system/
endef

$(eval $(autotools-package))
