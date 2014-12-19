#!/sbin/busybox ash
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

# check partition filesystem
getfs() { /sbin/busybox blkid $1 | /sbin/busybox cut -d\" -f4; }

# patch the fstab accordingly to the partitions' file systems
patch_fstab() {
  bb=/sbin/busybox;
  cache=/dev/block/platform/dw_mmc.0/by-name/cache;
  data=/dev/block/platform/dw_mmc.0/by-name/userdata;
  system=/dev/block/platform/dw_mmc.0/by-name/system;
  system1=/dev/block/platform/dw_mmc.0/by-name/system1;
  prefix=/dev/block/platform/dw_mmc.0/by-name;
  device=aries;

  # swap out entries for filesystems as detected
  for i in $system $system1 $cache $data; do
    fstype=`getfs $i`;
    fsentry=`$bb grep $i $ramdisk/fstab-$fstype.$device`;
    if [ "$fsentry" ]; then
      ui_print "${i#${prefix}}'s file system is $fstype";
      $bb sed -i "s|^$i.*|$fsentry|" $ramdisk/fstab.$device;
    fi;
  done;
  $bb rm -f /fstab-*;
}
