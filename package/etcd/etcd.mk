ETCD_VERSION = 8f3981c6514fa60b8b016dfc149fc6bbf540c895
ETCD_SITE = https://github.com/coreos/etcd.git
ETCD_SITE_METHOD = git
ETCD_DEPENDENCIES = host-golang

ETCD_ORG_PATH = "github.com/coreos"
ETCD_REPO_PATH = "$(ETCD_ORG_PATH)/etcd"

define ETCD_BUILD_CMDS
	rm -f $(@D)/gopath/src/$(ETCD_REPO_PATH)
	mkdir -p $(@D)/gopath/src/$(ETCD_ORG_PATH)
	ln -s $(@D) $(@D)/gopath/src/$(ETCD_REPO_PATH)
	$(GOLANG_ENV) GOPATH=$(@D)/gopath $(GOLANG) build -o $(@D)/bin/etcd $(ETCD_REPO_PATH)
	$(GOLANG_ENV) GOPATH=$(@D)/gopath $(GOLANG) build -o $(@D)/bin/etcdctl $(ETCD_REPO_PATH)/etcdctl
endef

define ETCD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bin/etcd $(TARGET_DIR)/usr/bin/etcd
	$(INSTALL) -D -m 0755 $(@D)/bin/etcdctl $(TARGET_DIR)/usr/bin/etcdctl
endef

define ETCD_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/contrib/systemd/etcd.service $(TARGET_DIR)/usr/lib/systemd/system/etcd.service
endef

define ETCD_USERS
	etcd -1 etcd -1 * /var/lib/etcd - - etcd user
endef

$(eval $(generic-package))
