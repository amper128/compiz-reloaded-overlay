# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Compiz Reloaded (meta)"
HOMEPAGE="https://gitlab.com/compiz"
SRC_URI=""

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="boxmenu +ccsm debugutils +emerald full +fusionicon manager simpleccsm"

RDEPEND="
	>=x11-plugins/compiz-plugins-meta-${PV}
	boxmenu? ( >=x11-apps/compiz-boxmenu-1.1.12 )
	ccsm? ( >=x11-misc/ccsm-${PV} )
	debugutils? ( >=x11-misc/compiz-debug-utils-0_pre20171023 )
	emerald? ( >=x11-wm/emerald-${PV} )
	full? (
		x11-plugins/compiz-plugins-meta[community,compicc,experimental,extra,extra-snowflake-textures]
		x11-wm/compiz
	)
	fusionicon? ( >=x11-apps/fusion-icon-0.2.2 )
	manager? ( >=x11-apps/compiz-manager-0.7.0 )
	simpleccsm? ( >=x11-misc/simple-ccsm-0.8.14.1 )
"
REQUIRED_USE="full? ( boxmenu ccsm debugutils emerald fusionicon manager simpleccsm )"
