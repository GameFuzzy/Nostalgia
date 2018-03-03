export ARCHS = armv7 armv7s arm64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Nostalgia
Nostalgia_FILES = Tweak.xm
Nostalgia_FRAMEWORK = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += nostalgiaprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
