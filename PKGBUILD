# Maintainer: Laura Demkowicz-Duffy <dev [at] demkowiczduffy [dot] co [dot] uk>
pkgname=btrfs-scrub-script
pkgver=0.4.0
pkgrel=1
pkgdesc="BTRFS Regular Maintenance Script"
arch=('any')
url="https://github.com/Laura7089/btrfs-scrub-script"
license=('Apache-2.0')
depends=('bash' 'btrfs-progs' 'inn' 'upower')
provides=('btrfs-scrub-script')
conflicts=('btrfs-scrub-script')
source=("btrfs-scrub.sh"
		"btrfs-scrub.service")
sha256sums=('3cba79a3be9d6ce335b363b4c07027cf1baebff8aea354735fa94a8e02c5207e'
            '5ff71f035858ee9531ef51ccb64b398e8f28051c8ba25188b9e09b3f0ea5e2c9')

package() {
	install -Dm0755 btrfs-scrub.sh "$pkgdir/usr/bin/$pkgname"
	install -Dm0644 btrfs-scrub.service "$pkgdir/usr/lib/systemd/system/$pkgname.service"
}
