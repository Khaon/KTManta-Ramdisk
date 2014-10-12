#!/sbin/busybox sh

/sbin/busybox mount -o remount,rw /;

/sbin/busybox mv /fstab.aries /fstab.org;

DATA=`/sbin/blkid /dev/block/mmcblk0p26 | grep "f2fs"`
CACHE=`/sbin/blkid /dev/block/mmcblk0p25 | grep "f2fs"`
SYSTEM=`/sbin/blkid /dev/block/mmcblk0p23 | grep "f2fs"`
SYSTEM1=`/sbin/blkid /dev/block/mmcblk0p24 | grep "f2fs"`

if [ "${CACHE}" != ""  ]; then
	/sbin/busybox sed -i 's,#CACHE_ISF2FS,,' /fstab.tmp;
else
	/sbin/busybox sed -i 's,#CACHE_ISEXT4,,' /fstab.tmp;
fi;
if [ "${DATA}" != "" ]; then
	/sbin/busybox sed -i 's,#DATA_ISF2FS,,' /fstab.tmp;
else
	/sbin/busybox sed -i 's,#DATA_ISEXT4,,' /fstab.tmp;
fi;
if [ "${SYSTEM}" != "" ]; then
	/sbin/busybox sed -i 's,#SYS_ISF2FS,,' /fstab.tmp;
else
	/sbin/busybox sed -i 's,#SYS_ISEXT4,,' /fstab.tmp;
fi;
if [ "${SYSTEM1}" != "" ]; then
	/sbin/busybox sed -i 's,#SYS1_ISF2FS,,' /fstab.tmp;
else
	/sbin/busybox sed -i 's,#SYS1_ISEXT4,,' /fstab.tmp;
fi;

/sbin/busybox mv /fstab.tmp /fstab.aries;
