import Quickshell
import Quickshell.Networking
import QtQuick
import QtQuick.Layouts

Rectangle {
    anchors.rightMargin: 8
    anchors.right: volHolder.left
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    radius: 25
    implicitWidth: root.implicitWidth + 30
    color: Networking.wifiEnabled ? Colors.psuedoBlack : Colors.lightRed


    RowLayout {
        anchors.centerIn: parent
        id:root
        spacing: 6

        property var wifiDevice: Networking.devices.values.find(d=>d.type === DeviceType.Wifi)
        property var active: wifiDevice ? wifiDevice.networks.values.find(n => n.connected) : null

        readonly property real signal: active ? active.signalStrength : 0
        readonly property string icon: {
            if (!Networking.wifiEnabled) return String.fromCodePoint(0xF05AA)
            if (!active) return String.fromCodePoint(0xF092D) //Fancy methods of grabbing the nerd font symbol we want
            let tier = signal >= 0.75 ? 4
                     : signal >= 0.5  ? 3
                     : signal >= 0.25 ? 2
                     : 1
            return String.fromCodePoint(0xF091F + (tier-1) * 3)
        }
        Text {
            id:symbol
            text: root.icon
            color: Colors.lightMain
        
            font {
                family: "JetBrainsMono Nerd Font Propo"
                pixelSize: 14
                
            }
        }

        Text {
            text: {
                if(!Networking.wifiEnabled) return "Off"
                if(!root.active) return "Disconnected"
                return root.active.name
            }
            font {
                family: "JetBrainsMono Nerd Font Propo"
                pixelSize: 14
            }
            color: Colors.lightMain
        }
        Text {
            text: {
               " | " + Math.round(root.active.signalStrength*100) + "%"
            }
            font {
                family: "JetBrainsMono Nerd Font Propo"
                pixelSize: 14
            }
            color: Colors.lightMain
        }
    }
    MouseArea{
        anchors.fill:parent
        onClicked: {
            Quickshell.execDetached({command:["kitty", "-e", "sh", "-c", "nmtui"]})
        }
    }
}