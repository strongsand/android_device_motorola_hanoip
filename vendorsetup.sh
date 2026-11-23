#
# OrangeFox fox_12.1 build environment for Motorola Moto G60 (hanoip)
# Based on validated TWRP 12.1 hanoip-voltageos-a17 tree.
#
FDEVICE="hanoip"

fox_get_target_device() {
    local chkdev=$(echo "$BASH_SOURCE" | grep -w "$FDEVICE")
    if [ -n "$chkdev" ]; then
        FOX_BUILD_DEVICE="$FDEVICE"
    else
        chkdev=$(set | grep BASH_ARGV | grep -w "$FDEVICE")
        [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
    fi
}

if [ -z "$1" ] && [ -z "$FOX_BUILD_DEVICE" ]; then
    fox_get_target_device
fi

if [ "$1" = "$FDEVICE" ] || [ "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export TW_DEFAULT_LANGUAGE="en"
    export LC_ALL="C"
    export ALLOW_MISSING_DEPENDENCIES=true
    export TARGET_DEVICE_ALT="hanoip"
    export FOX_TARGET_DEVICES="hanoip"
    export FOX_AB_DEVICE=1
    export FOX_VIRTUAL_AB_DEVICE=1
    export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
    export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
    export OF_SCREEN_H=2460
    export OF_STATUS_H=116
    export OF_STATUS_INDENT_LEFT=48
    export OF_STATUS_INDENT_RIGHT=48
    export OF_HIDE_NOTCH=1
    export OF_CLOCK_POS=1
    export OF_ALLOW_DISABLE_NAVBAR=0
    export OF_USE_GREEN_LED=0
    export OF_DEFAULT_KEYMASTER_VERSION=4.1
    export OF_DEFAULT_TIMEZONE="BRT3"
    export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
    export OF_NO_MIUI_PATCH_WARNING=1
    export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
    export OF_KEEP_DM_VERITY=1
    export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
    export OF_QUICK_BACKUP_LIST="/boot;/data;"
    export FOX_DELETE_AROMAFM=1
    export OF_USE_LZ4_COMPRESSION=1
    export OF_MAINTAINER="strongsand"
    export FOX_MAINTAINER_PATCH_VERSION=1
fi
