/*
    SPDX-FileCopyrightText: 2014 Martin Klapetek <mklapetek@kde.org>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

import QtQuick
import org.kde.plasma.core as PlasmaCore

PlasmaCore.Dialog {
    type: PlasmaCore.Dialog.Tooltip
    location: PlasmaCore.Types.TopEdge
    x: Math.round((Screen.width - width) / 2)
    y: 0
    outputOnly: true

    property alias timeout: osd.timeout
    property alias osdValue: osd.osdValue
    property alias osdMaxValue: osd.osdMaxValue
    property alias icon: osd.icon
    property alias showingProgress: osd.showingProgress

    mainItem: OsdItem {
        id: osd
    }
}
