TARGET = iphone:10.1:10.1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = FakeCallHistoryPreferences
FakeCallHistoryPreferences_FILES = NZHRootListController.m
FakeCallHistoryPreferences_INSTALL_PATH = /Library/PreferenceBundles
FakeCallHistoryPreferences_FRAMEWORKS = UIKit
FakeCallHistoryPreferences_PRIVATE_FRAMEWORKS = Preferences
FakeCallHistoryPreferences_EXTRA_FRAMEWORKS += Cephei CepheiPrefs


include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/FakeCallHistoryPreferences.plist$(ECHO_END)
