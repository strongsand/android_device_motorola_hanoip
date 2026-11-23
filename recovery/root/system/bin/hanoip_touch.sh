#!/system/bin/sh

touch_class=/sys/class/touchscreen/ilitek
upgrade=/proc/ilitek/fw_upgrade

case "$#" in
    0)
        if [ -r "$touch_class/vendor" ]; then
            printf '%s\n' 'Ilitek built-in driver detected.'
        else
            printf '%s\n' 'Ilitek probe not observed at boot.'
        fi
        exit 0
        ;;
    1)
        if [ "$1" = "--reflash" ]; then
            :
        else
            printf '%s\n' 'Usage: hanoip_touch.sh [--reflash]' >&2
            exit 2
        fi
        ;;
    *)
        printf '%s\n' 'Usage: hanoip_touch.sh [--reflash]' >&2
        exit 2
        ;;
esac

if [ "$(uname -r)" != 4.14.357-openela-WabiSabi ] ||
   [ "$(cat "$touch_class/vendor" 2>/dev/null)" != ilitek ] ||
   [ ! -r "$upgrade" ]; then
    printf '%s\n' 'WabiSabi Ilitek firmware interface unavailable.' >&2
    exit 1
fi

panel=$(sed -n 's/^Product ID: //p' "$touch_class/ic_ver" 2>/dev/null)
if [ "$panel" != TM ] || [ ! -s /vendor/firmware/FW_ILITEK_TDDI_TM.bin ]; then
    printf '%s\n' 'Ilitek TM panel or packaged firmware could not be confirmed.' >&2
    exit 1
fi

# Reading this proc entry initiates the update. The driver selects its firmware.
# The reply begins with two binary status bytes, followed by a text result.
if result=$(tr -d '\000' < "$upgrade"); then
    case "$result" in
        'Upgrade firmware = PASS'*) printf '%s\n' 'Ilitek firmware update reported success.'; exit 0 ;;
    esac
fi
printf '%s\n' 'Ilitek firmware update did not report success. Check kernel logs.' >&2
exit 1
