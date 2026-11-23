#!/system/bin/sh

# The built-in driver initializes touch. Record its status in RAM.
umask 077
/system/bin/sh /system/bin/hanoip_touch.sh > /tmp/TouchScreenlog.txt 2>&1

# Ensure recovery HALs are not hijacked by legacy /vendor/lib64/hw/*.so
# from older ROMs (e.g. A11/A12) and never pin /vendor busy.
sleep 2
need_hal_reset=0
for hp in $(pidof android.hardware.health@2.1-service 2>/dev/null); do
    if grep -q "/vendor/lib64/hw/" "/proc/$hp/maps" 2>/dev/null; then
        need_hal_reset=1
    fi
done
boot_state="$(getprop init.svc.boot-hal-1-2 2>/dev/null)"
if [ "$boot_state" != "running" ]; then
    need_hal_reset=1
fi
if [ "$need_hal_reset" = "1" ] && grep -q " /vendor " /proc/mounts 2>/dev/null; then
    stop health-hal-2-1
    stop boot-hal-1-2
    sleep 1
    umount /vendor 2>/dev/null
    start boot-hal-1-2
    start health-hal-2-1
fi
