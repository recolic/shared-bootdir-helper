# Maintainer: Recolic Keghart <root@recolic.net>
# Original repo: https://git.recolic.net/root/shared-bootdir-helper

pkgname=shared-bootdir-helper
pkgver=1.0
pkgrel=1
pkgdesc="Allow multiple linux installations to share the same /boot directory. Useful for deniable encryption. "
url="https://github.com/recolic/$pkgname"
license=("GPL3")
arch=("any")
depends=("bash" "sed" "grep" "mkinitcpio")
install="$pkgname.install"
source=(
    "$pkgname-$pkgver.tar.gz::$url/archive/v$pkgver.tar.gz"
    "$pkgname-$pkgver.tar.gz.sig::$url/releases/download/v$pkgver/v$pkgver.tar.gz.sig"
)
validpgpkeys=("6861D89984E7887F0FFE6E08C344D5EAE3933636")
sha256sums=(
    "SKIP"
    "SKIP"
)

package() {
    mkdir -p "$pkgdir/opt" "$pkgdir/usr/bin" &&
    cp -r "$pkgname-$pkgver" "$pkgdir/opt/vivado-wrapper" &&
    ln -s "/opt/vivado-wrapper/vivado-wrapper" "$pkgdir/usr/bin/vivadow"
}

