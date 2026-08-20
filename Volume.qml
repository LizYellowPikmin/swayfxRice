import Quickshell
import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Rectangle{
                PwObjectTracker { objects : {Pipewire.defaultAudioSink} }
                id:volHolder
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                radius: 25
                implicitWidth: textHelp.implicitWidth + 30
                color: Colors.psuedoBlack
                property var volSink: Pipewire.defaultAudioSink
                property int volLevel: Math.round((volSink?.audio?.volume ?? 0) * 100)
                property bool isMuted: volSink?.audio?.muted

                WrapperItem {
                    id:textHelp
                    anchors.centerIn: parent
                    Text{
                        anchors.centerIn: parent
                        
                        text: volHolder.isMuted ? "\ueee8" + " Muted" : (volHolder.volLevel > 50 ? "\uf028 " + volHolder.volLevel + "%" : (volHolder.volLevel > 0 ? "\uf027 " + volHolder.volLevel + "%" : "\uf026 " + "0%"))
                        color: Colors.lightMain
                        font {
                            family: "JetBrainsMono Nerd Font Propo"
                            pixelSize: 14
                        }
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Quickshell.execDetached(["easyeffects"])
                    }
                }
            }