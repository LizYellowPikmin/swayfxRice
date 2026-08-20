import Quickshell
import Quickshell.Services.UPower
import QtQuick
import Quickshell.Widgets

Rectangle {
                id:batHolder
                anchors.rightMargin: 8
                anchors.right: volHolder.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                property var batteryLevel: UPower.displayDevice.percentage*100
                
                radius: 25
                implicitWidth: textHelp.implicitWidth + 30
                color: batteryLevel > 20 ? Colors.lightMain : (batteryLevel > 10 ? Colors.lightPurple : Colors.lightRed)

                WrapperItem {
                    id:textHelp
                    anchors.centerIn: parent
                    Text {
                        anchors.centerIn: parent
                        //property string batterySymbol: UPower.displayDevice.state == UPowerDeviceState.Charging ? "🗲" : batHolder.batteryLevel > 80 ? "\uf240" : (batHolder.batteryLevel > 60 ? "\uf241" : (batHolder.batteryLevel > 40 ? "\uf242" : (batHolder.batteryLevel > 20 ? "\uf243" : "\uf244")))
                        readonly property string batterySymbol: {
                            if (UPower.displayDevice.state == UPowerDeviceState.Charging) return String.fromCodePoint(0xF0084)
                            if (batHolder.batteryLevel >= 100) return String.fromCodePoint(0xF0079)
                            if (batHolder.batteryLevel < 10) return String.fromCodePoint(0xF0083)

                            return String.fromCodePoint(0xF007A + Math.floor(batHolder.batteryLevel/10 - 1))            
                        }
                        readonly property string profileSymbol: {
                            if(PowerProfiles.profile == PowerProfiles.Performance) return "\uf463"
                            else if (PowerProfiles.profile == PowerProfiles.PowerSaver) return "\udb80\udf2a"
                        }
                
                        text: batterySymbol + " " + Math.round(batHolder.batteryLevel) + "%" + " " + profileSymbol
                        color: batHolder.batteryLevel > 20 ? Colors.psuedoBlack : (batHolder.batteryLevel > 10 ? Colors.darkPurple : Colors.darkRed)
                        font {
                            family: "JetBrainsMono Nerd Font Propo"
                            pixelSize: 14
                        }
                    }
                }
                MouseArea{
                    id: switcher
                    anchors.fill:parent
                    //hoverEnabled: true
                    onClicked: {
                        if ( PowerProfiles.profile == PowerProfiles.Performance ) PowerProfiles.profile = PowerProfiles.PowerSaver
                        else (PowerProfiles.profile = PowerProfiles.Performance)
                        //Quickshell.execDetached({command:["kitty", "--hold", "powerprofilesctl"]})
                }
    }
            }