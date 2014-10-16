#!/system/bin/sh

echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle;
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse;
echo 1024 > /proc/sys/kernel/random/read_wakeup_threshold;
echo 2048 > /proc/sys/kernel/random/write_wakeup_threshold;
echo 256000000 > /proc/sys/kernel/shmmax;
echo 1024000 > /proc/sys/net/core/rmem_max;
echo 1024000 > /proc/sys/net/core/wmem_max;
echo 0 > /proc/sys/vm/swappiness;
echo 50 > /proc/sys/vm/vfs_cache_pressure;

# General Tweaks, thanks to Osmosis and Malaroths for most of this
echo 2 > /sys/block/mmcblk0/queue/rq_affinity;
echo 0 > /sys/block/mmcblk0/queue/nomerges;
echo 0 > /sys/block/mmcblk0/queue/rotational;
echo 0 > /sys/block/mmcblk0/queue/add_random;
echo 0 > /sys/block/mmcblk0/queue/iostats;
echo 8192 > /proc/sys/vm/min_free_kbytes

echo $(date) END of post-init.sh
