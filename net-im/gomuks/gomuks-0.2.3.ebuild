# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit golang-build

DESCRIPTION="A terminal based Matrix client written in Go"
HOMEPAGE="https://github.com/tulir/${PN}"

if [[ "${PV}" != 9999 ]] ; then
	SRC_URI="https://github.com/tulir/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${P}"
	KEYWORDS="amd64 x86 ~arm64 ~ppc64"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tulir/${PN}"
fi

LICENSE="AGPL-3"
SLOT="0"
IUSE="+encryption"

DEPEND="encryption? ( dev-libs/olm )"
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/go"

src_compile() {
	use encryption || export CGO_ENABLED=0
	go build
}

src_install() {
	dobin ${PN}
}
