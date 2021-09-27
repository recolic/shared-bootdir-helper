# Maintainer: Recolic Keghart <root@recolic.net>
# Original repo: https://git.recolic.net/root/shared-bootdir-helper
# Mirror: https://github.com/recolic/shared-bootdir-helper

pkgname=shared-bootdir-helper
pkgver=1.0
pkgrel=1
pkgdesc="Allow multiple linux installations to share the same /boot directory, even with different kernel parameters. "
url="https://git.recolic.net/root/$pkgname"
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
    echo "DO NOT INSTALL ME! it's not finished..."
    return 1

    mkdir -p "$pkgdir/etc" "$pkgdir/usr/bin" "$pkgdir/usr/share/libalpm/hooks" &&
    cp src/*.cfg "$pkgdir/etc/" &&
    cp src/*.sh "$pkgdir/usr/bin/" &&
    cp src/*.hook "$pkgdir/usr/share/libalpm/hooks/" ||
    return $?
}

