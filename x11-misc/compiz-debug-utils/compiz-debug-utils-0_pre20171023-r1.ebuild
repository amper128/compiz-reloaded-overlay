# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_COMMIT="f700dd2b6af1f0c93b6b1eb1d75e658783f848e2"
PYTHON_COMPAT=( python3_{9,10,11} )

inherit python-single-r1

DESCRIPTION="Helper utilities for debugging Compiz"
HOMEPAGE="https://gitlab.com/compiz"
SRC_URI="https://github.com/compiz-reloaded/${PN}/archive/${MY_COMMIT}.zip -> ${P}-${MY_COMMIT}.zip"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
		>=x11-wm/compiz-0.8[dbus]
		<x11-wm/compiz-0.9[dbus]
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

src_install() {
	dodoc README.md
	rm README.md COPYING || die
	dobin *
}
