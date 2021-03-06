# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="A console based XMPP client inspired by Irssi"
HOMEPAGE="https://profanity-im.github.io"
if [[ "${PV}" != 9999 ]] ; then
	SRC_URI="https://profanity-im.github.io/${P}.tar.gz"
	S="${WORKDIR}/${P}"
	KEYWORDS="amd64 x86 ~arm64 ~ppc64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/profanity-im/profanity.git"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="libnotify omemo otr gpg test xscreensaver"
RESTRICT="!test? ( test )"

COMMON_DEPEND="
	dev-db/sqlite
	dev-libs/expat
	dev-libs/glib
	dev-libs/libstrophe:=
	dev-libs/openssl:0=
	net-misc/curl
	sys-apps/util-linux
	sys-libs/ncurses:=[unicode(+)]
	gpg? ( app-crypt/gpgme:= )
	libnotify? ( x11-libs/libnotify )
	omemo? (
		net-libs/libsignal-protocol-c
		dev-libs/libgcrypt
	)
	otr? ( net-libs/libotr )
	xscreensaver? (
		x11-libs/libXScrnSaver
		x11-libs/libX11 )
	"
DEPEND="${COMMON_DEPEND}
	test? ( dev-util/cmocka )
"
RDEPEND="${COMMON_DEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable libnotify notifications) \
		$(use_enable omemo) \
		$(use_enable otr) \
		$(use_enable gpg pgp) \
		$(use_with xscreensaver)
}
