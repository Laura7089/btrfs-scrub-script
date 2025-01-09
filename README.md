# `btrfs-scrub` Script

The script I run regularly to maintain my BTRFS volumes.
The script itself and systemd service/timer files are provided.

Adapted from [Marc Merlin's script](https://marc.merlins.org/linux/scripts/btrfs-scrub); see [the blog post](https://marc.merlins.org/perso/btrfs/post_2014-03-19_Btrfs-Tips_-Btrfs-Scrub-and-Btrfs-Filesystem-Repair.html).

## Arch

A `PKGBUILD` file is provided to install this as a package under Arch Linux.
`makepkg -si` should do the trick.
Note that the timer is not included in the package, since the user may want to adjust the timing of the script run.
You can "install" it with:

```bash
sudo install -Dm0644 btrfs-scrub.timer /etc/systemd/system/btrfs-scrub-script.timer
```
