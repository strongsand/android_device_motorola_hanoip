#!/system/bin/sh

# The built-in driver initializes touch. Record its status in RAM.
umask 077
exec /system/bin/sh /system/bin/hanoip_touch.sh > /tmp/TouchScreenlog.txt 2>&1
