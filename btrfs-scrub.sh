#! /bin/bash

# By Marc MERLIN <marc_soft@merlins.org> 2014/03/20
# Modifications by Laura Demkowicz-Duffy <dev at demkowiczduffy.co.uk> 2025
# License: Apache-2.0

which btrfs >/dev/null || exit 0

export PATH="/usr/local/bin:/sbin:$PATH"

# bash shortcut for `basename $0`
PROG=${0##*/}
lock="/var/run/$PROG"

test_battery() {
    ON_BATTERY=0
    BATT="$(upower -e | grep BAT | head -1)"
    upower -i "$BATT" | grep -E 'state: \+charging' || ON_BATTERY=$?
    if [ "$ON_BATTERY" -eq 1 ]; then
        logger -s "warn: on battery, skipping BTRFS scrub"
        exit 0
    fi
}

test_battery

# shlock (from inn) does the right thing and grabs a lock for a dead process
# (it checks the PID in the lock file and if it's not there, it
# updates the PID with the value given to -p)
if ! shlock -p $$ -f "$lock"; then
    echo "$lock held, quitting" >&2
    exit
fi

FILTER='(^Dumping|balancing, usage)'
BTRFS_SCRUB_SKIP="noskip"
source /etc/btrfs_config 2>/dev/null
test -n "$DEVS" || DEVS=$(grep '\<btrfs\>' /proc/mounts | awk '{ print $1 }' | sort -u | grep -v $BTRFS_SCRUB_SKIP)
for btrfs in $DEVS
do
    test_battery
    tail -n 0 -f /var/log/syslog | grep "BTRFS" | grep -Ev '(disk space caching is enabled|unlinked .* orphans|turning on discard|device label .* devid .* transid|enabling SSD mode|BTRFS: has skinny extents|BTRFS: device label|BTRFS info )' &
    mountpoint="$(grep "$btrfs" /proc/mounts | awk '{ print $2 }' | sort | head -1)"
    logger -s "info: Quick Metadata and Data Balance of '$mountpoint' ($btrfs)"
    # Even in 4.3 kernels, you can still get in places where balance
    # won't work (no place left, until you run a -m0 one first)
    # I'm told that proactively rebalancing metadata may not be a good idea.
    #btrfs balance start -musage=20 -v "$mountpoint" 2>&1 | grep -Ev "$FILTER"
    # but a null rebalance should help corner cases:
    sleep 10
    btrfs balance start -musage=0 -v "$mountpoint" | grep -Ev "$FILTER"
    # After metadata, let's do data:
    sleep 10
    btrfs balance start -dusage=0 -v "$mountpoint" | grep -Ev "$FILTER"
    sleep 10
    btrfs balance start -dusage=20 -v "$mountpoint" | grep -Ev "$FILTER"
    # And now we do scrub. Note that scrub can fail with "no space left
    # on device" if you're very out of balance.
    test_battery
    logger -s "info: Starting scrub of '$mountpoint'"
    echo btrfs scrub start -Bd "$mountpoint"
    # -r is read only, but won't fix a redundant array.
    #ionice -c 3 nice -10 btrfs scrub start -Bdr "$mountpoint"
    time ionice -c 3 nice -10 btrfs scrub start -Bd "$mountpoint"
    pkill -f 'tail -n 0 -f /var/log/syslog'
    logger -s "info: Ended scrub of '$mountpoint'"
done

rm "$lock"
