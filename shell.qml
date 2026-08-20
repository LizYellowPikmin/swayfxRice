import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire

Scope {
    Variants {
        model: Quickshell.screens
        // THE WHOLE BAR
        PanelWindow {
            anchors{
                bottom:true
            }
            height:40 
            width: 1150
            color: "transparent"

            //CLOCK SET UP
            Rectangle{
                
                anchors.centerIn: parent
                color:Colors.psuedoBlack
                radius:20
                height:40
                width:70
                
                Clock{
                    anchors.centerIn: parent
                    

                }
            }

            //This adds our workspaces
            WSpaces {} //its condensed because its like 50 lines long since i did a lot of bs to experiment/troubleshoot and have not bothered to fix it yet

            //Volume
            Volume{
                id:vol
            }
            

            //Battery
            Battery{
                id:bat
                anchors.right:vol.left
            }

            //WIFIIII
            Network{
                id:net
                anchors.right: bat.left
            }
        }
    }
}