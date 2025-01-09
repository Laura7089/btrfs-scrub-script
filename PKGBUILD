# Maintainer: Laura Demkowicz-Duffy <dev [at] demkowiczduffy [dot] co [dot] uk>
pkgname=btrfs-scrub-script
pkgver=0.1.0
pkgrel=1
pkgdesc="BTRFS Regular Maintenance Script"
arch=('any')
url="https://github.com/Laura7089/btrfs-scrub-script"
license=('Apache-2.0')
depends=('bash' 'btrfs-progs' 'inn')
provides=('btrfs-scrub-script')
conflicts=('btrfs-scrub-script')
source=("btrfs-scrub.sh"
		"btrfs-scrub.service")
sha256sums=('df4f7aa95a80c01fd6ce318fc46b95600e5d61bf3b279328eb4b629160cab84c'
            '5ff71f035858ee9531ef51ccb64b398e8f28051c8ba25188b9e09b3f0ea5e2c9')

package() {
	install -Dm0755 btrfs-scrub.sh "$pkgdir/usr/bin/btrfs-scrub-script"
	install -Dm0644 btrfs-scrub.service "$pkgdir/usr/lib/systemd/system/btrfs-scrub.service"
}
