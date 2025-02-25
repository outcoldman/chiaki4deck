import QtQuick
import QtQuick.Controls

import org.streetpea.chiaki4deck

Rectangle {
    id: view
    property bool allowClose: false
    color: "black"

    function stop() {
        if (!allowClose)
            return;
        Chiaki.stopAutoConnect();
        root.showMainView();
    }

    Keys.onReturnPressed: view.stop()
    Keys.onEscapePressed: view.stop()

    MouseArea {
        anchors.fill: parent
        enabled: view.allowClose
        onClicked: view.stop()
    }

    Label {
        id: infoLabel
        anchors.centerIn: parent
        opacity: view.allowClose ? 1.0 : 0.0
        visible: opacity
        text: qsTr("Waiting for console...")

        Behavior on opacity { NumberAnimation { duration: 250 } }
    }

    Timer {
        interval: 1500
        running: true
        onTriggered: view.allowClose = true
    }
}
