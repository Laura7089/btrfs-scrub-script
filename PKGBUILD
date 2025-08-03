# Maintainer: Laura Demkowicz-Duffy <dev [at] demkowiczduffy [dot] co [dot] uk>
pkgname=btrfs-scrub-script
pkgver=0.5.0
pkgrel=2
pkgdesc="BTRFS Regular Maintenance Script"
arch=('any')
url="https://github.com/Laura7089/btrfs-scrub-script"
license=('Apache-2.0')
depends=('bash' 'btrfs-progs' 'util-linux' 'upower' 'time')
provides=('btrfs-scrub-script')
conflicts=('btrfs-scrub-script')
source=("btrfs-scrub.sh"
		"btrfs-scrub.service")
sha256sums=('c8581d6541f299a4782f0b72d793d2813f6adb89bfbe3672d40f38ecead8b7a2'
            '5ff71f035858ee9531ef51ccb64b398e8f28051c8ba25188b9e09b3f0ea5e2c9')

package() {
	install -Dm0755 btrfs-scrub.sh "$pkgdir/usr/bin/$pkgname"
	install -Dm0644 btrfs-scrub.service "$pkgdir/usr/lib/systemd/system/$pkgname.service"
}
