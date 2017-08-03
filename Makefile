include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FakeCallHistory
FakeCallHistory_FILES = Tweak.xm
FakeCallHistory_EXTRA_FRAMEWORKS += Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += fakecallhistorypreferences
include $(THEOS_MAKE_PATH)/aggregate.mk
