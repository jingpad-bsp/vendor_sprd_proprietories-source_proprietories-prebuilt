MY_MODULE_SOURCE_DIR := $(TOP)/vendor/sprd/proprietories-source
MY_TARGET_MODULE = $(call find-files-in-subdirs,$(TARGET_OUT),$(LOCAL_MODULE).apk,.)

LOCAL_PATH := $(call my-dir)

define proprietary-prebuild
$(if $(filter $(MY_MODULE_SOURCE_DIR)/$(1)/Android.mk,$(wildcard $(MY_MODULE_SOURCE_DIR)/$(1)/Android.mk)), \
  $(info [proprietories-prebuilt]This is full build, skipping $(1)!),\
  $(if $(strip $(MY_TARGET_MODULE)),\
    $( \
      $(shell mkdir -p $(dir $(LOCAL_PATH)/$(MY_TARGET_MODULE)) && cp -f $(TARGET_OUT)/$(MY_TARGET_MODULE) $(dir $(LOCAL_PATH)/$(MY_TARGET_MODULE))) \
      $(eval LOCAL_SRC_FILES := $(MY_TARGET_MODULE)) \
      $(eval include $(BUILD_PREBUILT)) \
    ), \
    $(info [proprietories-prebuilt]This is idh build, $(1) could not be found, Noop!) \
  ) \
)
endef

#########################
#customized properties
#########################
#prebuild for USCPhotosProvider
include $(CLEAR_VARS)
LOCAL_MODULE := USCPhotosProvider
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := APPS
LOCAL_CERTIFICATE := media
LOCAL_DEX_PREOPT := false
LOCAL_PRIVILEGED_MODULE := true
MODULE_DIR := ../platform/packages/providers/USCPhotosProvider/prebuilt
$(call proprietary-prebuild,$(MODULE_DIR))

#RD need to keep these prop same with sprd/proprietories-source/volte_engine/vce/app_video_service/Android.mk
#prebuild for VceDaemon
#Generate VceDamon.apk's makefile is in volte_engine/vce/app_video_service
include $(CLEAR_VARS)
LOCAL_MODULE := VceDaemon
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := APPS
LOCAL_CERTIFICATE := platform
LOCAL_DEX_PREOPT := true
LOCAL_PRIVILEGED_MODULE := false
MODULE_DIR := volte_engine
$(call proprietary-prebuild,$(MODULE_DIR))

#RD need to keep these prop same with sprd/sprd_vowifi/source_code/SprdVoWifiService/Android.mk
#prebuild for SprdVoWifiService
#Generate SprdVoWifiService.apk's makefile is in sprd/sprd_vowifi/source_code/SprdVoWifiService
include $(CLEAR_VARS)
LOCAL_MODULE := SprdVoWifiService
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := APPS
LOCAL_CERTIFICATE := platform
LOCAL_DEX_PREOPT := true
LOCAL_PRIVILEGED_MODULE := true
MODULE_DIR := ../sprd_vowifi/source_code/SprdVoWifiService
$(call proprietary-prebuild,$(MODULE_DIR))

#RD need to keep these prop same with sprd/proprietories-source/ImsCM/Android.mk
#prebuild for ImsCM
include $(CLEAR_VARS)
LOCAL_MODULE := ImsCM
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := APPS
LOCAL_CERTIFICATE := platform
LOCAL_DEX_PREOPT := true
LOCAL_PRIVILEGED_MODULE := true
$(call proprietary-prebuild,$(LOCAL_MODULE))
#########################
#customized properties
#########################

MY_TARGET_MODULE :=
MY_MODULE_SOURCE_DIR :=

