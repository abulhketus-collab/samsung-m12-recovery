# Vendorsetup for Samsung Galaxy M12 (m12)
export CURR_DEVICE="m12"
export FDEVICE1="m12"
export ALLOW_MISSING_DEPENDENCIES=true
export BOARD_RAMDISK_USE_LZMA=true
export LC_ALL="C"

# Apply OrangeFox-specific patches ONLY if building inside an OrangeFox tree
if [ -f "bootable/recovery/orangefox_defaults.go" ]; then
    echo "OrangeFox environment detected. Applying OrangeFox patches..."
    if [ -f "device/samsung/m12/source_changes/bootable.tar.xz" ]; then
        tar -xJf device/samsung/m12/source_changes/bootable.tar.xz -C bootable/recovery 2>/dev/null || true
    fi
    if [ -f "device/samsung/m12/colour_fix.diff" ]; then
        cd bootable/recovery
        patch -p1 -N -r - < ../../device/samsung/m12/colour_fix.diff 2>/dev/null || true
        cd ../../
    fi
    SRC="device/samsung/m12/source_changes/maintainer/processed_image1.png"
    DST="bootable/recovery/gui/theme/portrait_hdpi/images/Default/About/maintainer.png"
    if [ -f "$SRC" ]; then
        mkdir -p "$(dirname "$DST")" 2>/dev/null || true
        cp -v "$SRC" "$DST" 2>/dev/null || true
    fi
    export OF_MAINTAINER="TheDarkDeath788"
    export FOX_BUILD_TYPE="Stable"
    export FOX_VERSION="R12.1_62"
    export FOX_VARIANT="AOSP"
    export FOX_VANILLA_BUILD=1
    export FOX_DELETE_AROMAFM=0
    export OF_WIPE_METADATA_AFTER_DATAFORMAT=1
    export FOX_ENABLE_APP_MANAGER=1
    export OF_USE_SAMSUNG_HAPTICS=1
    export OF_USE_TWRP_SAR_DETECT=1
    export OF_QUICK_BACKUP_LIST="/super;/boot;/vbmeta;/dtbo;/efs;/sec_efs"
    export FOX_REPLACE_TOOLBOX_GETPROP=1
    export OF_USE_SYSTEM_FINGERPRINT=1
fi

# MKBOOTIMG executable permission
chmod a+x device/samsung/m12/prebuilt/mkboot/mkbootimg 2>/dev/null || true

# Common TWRP flags
export FOX_TARGET_DEVICES="m12, m12ub, SM-M127M, SM-M127F"
export TARGET_DEVICE_ALT="m12, m12ub, SM-M127M, SM-M127F"
export FOX_BUILD_DEVICE="m12, m12ub, SM-M127M, SM-M127F"

export OF_USE_LZMA_COMPRESSION=1
export OF_ENABLE_FS_COMPRESSION=1
export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/by-name/recovery"
export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"

echo "m12 environment variables configured successfully."
