include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = NostalgiaPrefs
NostalgiaPrefs_FILES = ZNPRootListController.m
NostalgiaPrefs_INSTALL_PATH = /Library/PreferenceBundles
NostalgiaPrefs_FRAMEWORKS = UIKit
NostalgiaPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NostalgiaPrefs.plist$(ECHO_END)
