# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11,12} )
DISTUTILS_IN_SOURCE_BUILD=1
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 xdg-utils

DESCRIPTION="Compiz settings manager focused on simplicity for an end-user"
HOMEPAGE="https://gitlab.com/compiz"
SRC_URI="https://gitlab.com/compiz/${PN}/uploads/3ead682645ec219bf215e86a66f8180f/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk3"

DEPEND="
	dev-util/intltool
	virtual/pkgconfig
"

RDEPEND="
	>=dev-python/compizconfig-python-0.8[${PYTHON_SINGLE_USEDEP}]
	<dev-python/compizconfig-python-0.9
	$(python_gen_cond_dep '
		dev-python/pycairo[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	>=x11-misc/ccsm-0.8[gtk3=,${PYTHON_SINGLE_USEDEP}]
	<x11-misc/ccsm-0.9
"

src_configure() {
	DISTUTILS_ARGS=(
		build
		"--prefix=/usr"
		"--with-gtk=$(usex gtk3 3.0 2.0)"
	)
}

pkg_postinst() {
	gtk-update-icon-cache
}

pkg_postrm() {
	gtk-update-icon-cache
}
