# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11,12} )
DISTUTILS_IN_SOURCE_BUILD=1
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 git-r3 xdg-utils

DESCRIPTION="Compiz settings manager focused on simplicity for an end-user"
HOMEPAGE="https://gitlab.com/compiz"
EGIT_REPO_URI="https://github.com/compiz-reloaded/simple-ccsm.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="gtk3"

DEPEND="
	dev-util/intltool
	virtual/pkgconfig
"

RDEPEND="
	>=dev-python/compizconfig-python-${PV}[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/pycairo[${PYTHON_USEDEP}]
	')
	$(python_gen_cond_dep '
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	>=x11-misc/ccsm-${PV}[gtk3=,${PYTHON_SINGLE_USEDEP}]
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
