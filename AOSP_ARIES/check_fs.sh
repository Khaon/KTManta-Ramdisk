#!/sbin/busybox sh
# Copyright (c) 2012, Code Aurora Forum. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of Code Aurora Forum, Inc. nor the names of its
#       contributors may be used to endorse or promote products derived
#      from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

/sbin/busybox mount -o remount,rw /;

/sbin/busybox mv /fstab.aries /fstab.org;

DATA=`/sbin/blkid /dev/block/mmcblk0p26 | grep "f2fs"`;
CACHE=`/sbin/blkid /dev/block/mmcblk0p25 | grep "f2fs"`;
SYSTEM=`/sbin/blkid /dev/block/mmcblk0p23 | grep "f2fs"`;
SYSTEM1=`/sbin/blkid /dev/block/mmcblk0p24 | grep "f2fs"`;

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
