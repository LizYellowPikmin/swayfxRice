import Quickshell
import Quickshell.Wayland
import QtQuick

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {

            anchors {
                bottom: true
                right: true
            }

            margins {
                right: 16
            }

            implicitWidth: 128
            implicitHeight: 128

            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.namespace: "rainbowpls"
            mask: Region {}

            exclusionMode: ExclusionMode.Ignore
            focusable: false

            color: "transparent"


            AnimatedImage {
                id: rainbowpls
                source: "./rainbowpls.gif"

                anchors.fill: parent
                fillMode: AnimatedImage.PreserveAspectFit
                playing: true
            }
        }
    }
}