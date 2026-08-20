import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

Rectangle{ //The Rounded Rectangle surrounding our workspaces
                id:"wspaceDock"
                property int maxId: { // largest workspace known so we can ensure that 
                //the surrounding shape contains it
                    let www = Hyprland.workspaces.values;
                    return www.length > 0 ? www[www.length - 1].id : 1;
                }
                color: Colors.psuedoBlack
                radius: 20
                anchors.left: parent.left
                height: 40
                implicitWidth: wsLayout.implicitWidth + 30

                RowLayout { // Puts shit in a row
                id:wsLayout
                anchors.fill: parent
                anchors.margins: 8
                //how the row is constructed ^

                Repeater {
                    model: wspaceDock.maxId //i=0, i<=the biggest workspace that exists
                    delegate: Rectangle {//Puts a unique rectangle on each iteration of repeater
                        property var exists: Hyprland.workspaces.values.find(w => w.id == index+1)
                        property var isFocused: Hyprland.focusedWorkspace?.id == (index+1)
                        property var isUrgent: Hyprland.workspaces.values.find(w=>w.id==index+1).urgent
                        implicitWidth: isFocused ? 50 : 26
                        height: 26
                        radius: 15
                        border.width: 1
                        border.color: isUrgent ? Colors.lightPink : (exists ? Colors.lightMain : "transparent")
                        color:isUrgent ? Colors.darkPink: (isFocused ? Colors.lightMain : (exists? Colors.midMain : "transparent"))
                        Text {
                            anchors.centerIn: parent
                            property var ws: Hyprland.workspaces.values.find(w => w.id == index+1)
                            property bool isActive: Hyprland.focusedWorkspace?.id == (index+1)
                            text: index + 1
                            color: isUrgent ? Colors.lightPink : (isActive ? Colors.midMain : (ws? Colors.lightMain : "transparent"))
                            font { pixelSize: 14; bold: true; family: "JetBrainsMono Nerd Font Propo" }
                        }
                        Behavior on color {
                            ColorAnimation {duration: 150}
                        }

                        Behavior on implicitWidth{
                            NumberAnimation {
                                duration: 150
                                easing.type: Easing.InOutQuad
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: Hyprland.dispatch("hl.dsp.focus({workspace = "+(index+1)+"})")
                        }
                    }
                }                
            }
            Item { Layout.fillWidth: true}
            }