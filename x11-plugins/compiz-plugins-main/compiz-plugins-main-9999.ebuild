# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3 xdg-utils

DESCRIPTION="Compiz Window Manager: Plugins"
HOMEPAGE="https://gitlab.com/compiz"
EGIT_REPO_URI="https://github.com/compiz-reloaded/compiz-plugins-main.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""

RDEPEND="
	gnome-base/librsvg
	virtual/jpeg:0
	virtual/glu
	>=x11-libs/compiz-bcop-${PV}
	>=x11-wm/compiz-${PV}
	x11-libs/cairo[X]
"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"

src_prepare(){
	default
	eautoreconf
}

src_configure() {
	econf \
		--enable-fast-install \
		--disable-static
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}

compiz_icon_cache_update() {
	# Needed because compiz needs its own icon cache.
	# Based on https://gitweb.gentoo.org/repo/gentoo.git/tree/eclass/gnome2-utils.eclass#n241
	local dir="${EROOT}/usr/share/compiz/icons/hicolor"
	local updater="${EROOT}/usr/bin/gtk-update-icon-cache"
	if [[ -n "$(ls "$dir")" ]]; then
		"${updater}" -q -f -t "${dir}"
		rv=$?

		if [[ ! $rv -eq 0 ]] ; then
			debug-print "Updating cache failed on ${dir}"

			# Add to the list of failures
			fails+=( "${dir}" )

			retval=2
		fi
	elif [[ $(ls "${dir}") = "icon-theme.cache" ]]; then
		# Clear stale cache files after theme uninstallation
		rm "${dir}/icon-theme.cache"
	fi

	if [[ -z $(ls "${dir}") ]]; then
		# Clear empty theme directories after theme uninstallation
		rmdir "${dir}"
	fi
}

pkg_postinst() {
	gtk-update-icon-cache
	compiz_icon_cache_update
}

pkg_postrm() {
	gtk-update-icon-cache
	compiz_icon_cache_update
}
