LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm

LOCAL_MODULE := esp-jni

LOCAL_SRC_FILES := esp-jni.c esp.s

include $(BUILD_SHARED_LIBRARY)
