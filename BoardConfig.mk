#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 The TWRP Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/samsung/m12

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# Architecture
TARGET_ARCH                := arm64
TARGET_ARCH_VARIANT        := armv8-a
TARGET_CPU_ABI             := arm64-v8a
TARGET_CPU_ABI2            := 
TARGET_CPU_VARIANT         := generic
TARGET_CPU_VARIANT_RUNTIME := generic

TARGET_2ND_ARCH                := arm
TARGET_2ND_ARCH_VARIANT        := armv7-a-neon
TARGET_2ND_CPU_ABI             := armeabi-v7a
TARGET_2ND_CPU_ABI2            := armeabi
TARGET_2ND_CPU_VARIANT         := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a15

TARGET_USES_64_BIT_BINDER   := true
TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_BOARD_SUFFIX := _64

TARGET_CPU_SMP    := true
ENABLE_CPUSETS    := true
ENABLE_SCHEDBOOST := true

# Bootloader & SoC
BOARD_VENDOR                 := samsung
TARGET_SOC                   := universal3830
TARGET_BOOTLOADER_BOARD_NAME := exynos850
TARGET_NO_BOOTLOADER         := true
TARGET_NO_RADIOIMAGE         := true
TARGET_USES_UEFI             := false
TARGET_SCREEN_DENSITY        := 300

# Kernel Parameters (strictly verified against stock boot.img)
BOARD_BOOT_HEADER_VERSION    := 2
BOARD_KERNEL_BASE            := 0x10000000
BOARD_KERNEL_PAGESIZE        := 2048
BOARD_RAMDISK_OFFSET         := 0x01000000
BOARD_KERNEL_TAGS_OFFSET     := 0x00000100
BOARD_DTB_OFFSET             := 0x00000000

BOARD_KERNEL_CMDLINE := \
	androidboot.hardware=exynos850 \
	androidboot.selinux=permissive \
	loop.max_part=7 \
	androidboot.usbcontroller=13600000.dwc3 \
	androidboot.usbconfigfs=true

# Prebuilt Kernel & DTBs
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
    TARGET_PREBUILT_KERNEL   := $(DEVICE_PATH)/prebuilt/zImage
    TARGET_PREBUILT_DTB      := $(DEVICE_PATH)/prebuilt/dtb.img
    BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
    BOARD_INCLUDE_DTB_IN_BOOTIMG := true
    BOARD_KERNEL_SEPARATED_DTBO  := true
endif

# Mkbootimg arguments
BOARD_MKBOOTIMG_ARGS += --base $(BOARD_KERNEL_BASE)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --board SRPTJ05C009

BOARD_CUSTOM_BOOTIMG_MK := $(DEVICE_PATH)/prebuilt/mkboot/bootimg.mk

# Partition Sizes (Verified from /proc/partitions)
BOARD_FLASH_BLOCK_SIZE             := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE     := 46137344
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 55574528

# Super & Dynamic Partitions (Calculated from mmcblk0p31: 5877760 * 1024 = 6018826240)
BOARD_SUPER_PARTITION_SIZE                      := 6018826240
BOARD_GOOGLE_DYNAMIC_PARTITIONS_SIZE            := 6014631936
BOARD_SUPER_PARTITION_GROUPS                    := google_dynamic_partitions
BOARD_GOOGLE_DYNAMIC_PARTITIONS_PARTITION_LIST := \
	system \
	vendor \
	product \
	odm

TARGET_COPY_OUT_VENDOR := vendor
TARGET_BOARD_PLATFORM  := universal3830

# Recovery Filesystems
BOARD_INCLUDE_RECOVERY_DTBO := true
TARGET_USERIMAGES_USE_EXT4  := true
TARGET_USERIMAGES_USE_F2FS  := true

# Android Verified Boot
BOARD_AVB_ENABLE := false

# Platform Version Spoofing
PLATFORM_SECURITY_PATCH         := 2099-12-31
VENDOR_SECURITY_PATCH           := 2099-12-31
PLATFORM_VERSION                := 16.1.0
TW_INCLUDE_CRYPTO               := false
TW_INCLUDE_CRYPTO_FBE           := false
TW_INCLUDE_FBE_METADATA_DECRYPT := false

# Partitions in Recovery
BOARD_USES_METADATA_PARTITION := true
BOARD_ROOT_EXTRA_FOLDERS += \
	cache \
	carrier \
	efs \
	metadata \
	omr \
	optics \
	prism \
	sec_efs \
	spu

# CRITICAL: LZMA Ramdisk Compression (mandatory to fit in 55.57 MB)
BOARD_RAMDISK_USE_LZMA := true
LZMA_COMPRESSION       := -9
LZMA_RAMDISK_TARGETS   := recovery

# Storage
TW_INTERNAL_STORAGE_PATH        := "/data/media/0"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH        := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
BOARD_HAS_NO_REAL_SDCARD        := true
RECOVERY_SDCARD_ON_DATA         := true

# Screen & Graphics
TARGET_RECOVERY_PIXEL_FORMAT     := ABGR_8888
TW_BRIGHTNESS_PATH               := "/sys/class/backlight/panel/brightness"
TW_MAX_BRIGHTNESS                := 306
TW_DEFAULT_BRIGHTNESS            := 153
TW_FRAMERATE                     := 60
TARGET_SCREEN_WIDTH              := 720
TARGET_SCREEN_HEIGHT             := 1600
TW_THEME                         := portrait_hdpi
RECOVERY_GRAPHICS_USE_LINELENGTH := true

# TWRP Settings
TARGET_SYSTEM_PROP          := $(DEVICE_PATH)/system.prop
TW_HAS_DOWNLOAD_MODE        := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_NO_REBOOT_BOOTLOADER     := true
TW_USE_TOOLBOX              := true
TW_INCLUDE_REPACKTOOLS      := true
TW_EXTRA_LANGUAGES          := true
TW_INCLUDE_RESETPROP        := true
TW_INCLUDE_NTFS_3G          := true
