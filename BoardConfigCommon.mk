#
# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

COMMON_PATH := device/samsung/universal9610-common

# Include
TARGET_SPECIFIC_HEADER_PATH := $(COMMON_PATH)/include

# Audio
TARGET_EXCLUDES_AUDIOFX := true
USE_XML_AUDIO_POLICY_CONF := 1

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(COMMON_PATH)/bluetooth

# Firmware
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Platform
BOARD_VENDOR := samsung

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a73

# Secondary Architecture
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

# Extracted with libbootimg
BOARD_KERNEL_OFFSET          := 0x00008000
BOARD_KERNEL_RAMDISK_OFFSET  := 0x01000000
BOARD_KERNEL_TAGS_OFFSET     := 0x00000100
BOARD_KERNEL_DTB_OFFSET      := 0x00000000
BOARD_BOOT_HEADER_VERSION := 2
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --kernel_offset $(BOARD_KERNEL_OFFSET)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_KERNEL_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --board $(BOARD_BOOT_HEADER_NAME)
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_KERNEL_DTB_OFFSET)
TARGET_KERNEL_CLANG_COMPILE := true

# Kernel
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
BOARD_CUSTOM_BOOTIMG         := true
BOARD_CUSTOM_BOOTIMG_MK      := $(COMMON_PATH)/kernel/mkbootimg.mk

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072    # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4

# FMRadio
BOARD_HAVE_SLSI_FM := true

# Filesystem
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_FS_CONFIG_GEN := $(COMMON_PATH)/config.fs

# Ramdisk
BOARD_ROOT_EXTRA_FOLDERS := \
    prism \
    optics \
    metadata \
    efs \
    carrier \
    dqmdbg \
    spu \
    keydata \
    keyrefuge

# Recovery
BOARD_HAS_DOWNLOAD_MODE := true
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_RECOVERY_PIXEL_FORMAT := "ABGR_8888"

# VNDK
BOARD_VNDK_VERSION := current
PRODUCT_TARGET_VNDK_VERSION := 29

# Vendor
TARGET_COPY_OUT_VENDOR := vendor
BUILD_WITHOUT_VENDOR := true

# Enable 64-bits binder
TARGET_USES_64_BIT_BINDER := true

# Graphics
TARGET_USES_HWC2 := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
OVERRIDE_RS_DRIVER := libRSDriverArm.so
BACKLIGHT_PATH := "/sys/class/backlight/panel/brightness"

# HIDL
DEVICE_FRAMEWORK_MANIFEST_FILE := $(COMMON_PATH)/framework_manifest.xml

# Properties
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# SELinux
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += $(COMMON_PATH)/sepolicy/private

### ANDROID VERIFIED BOOT
BOARD_AVB_ENABLE := true
ifeq ($(BOARD_AVB_ENABLE), true)
ifneq ($(LINEAGE_AVB_KEY_PATH),)
BOARD_AVB_KEY_PATH := $(LINEAGE_AVB_KEY_PATH)
else
BOARD_AVB_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
endif
BOARD_AVB_RECOVERY_KEY_PATH := $(BOARD_AVB_KEY_PATH)
BOARD_AVB_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_ALGORITHM := $(BOARD_AVB_ALGORITHM)
BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(BOARD_AVB_ROLLBACK_INDEX)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 0
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --algorithm NONE
endif # BOARD_AVB_ENABLE

# Inherit from the proprietary version
-include vendor/samsung/universal9610-common/BoardConfigVendor.mk
