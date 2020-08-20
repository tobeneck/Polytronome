import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12 //for Row/Column Layout
import QtQuick.Controls 2.12 //for Button and popup

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Polytronome")

    ToolButton{
        anchors.top: parent.top
        anchors.right: parent.right
        text: "info"
        onClicked: popup.open()
    }

    ColumnLayout{
        anchors.fill: parent

        BarBeats{
            id: primary
            Layout.fillWidth: parent

            tempo : bpmSpinBox.value

            onTicksPerBarChanged: secondary.ticksPerBeat = ticksPerBar / secondary.ticksPerBar

            height: 75
        }

        BarBeats{
            id: secondary
            Layout.fillWidth: parent

            tempo: bpmSpinBox.value

            ticksPerBeat: primary.ticksPerBar / ticksPerBar

            onTicksPerBarChanged: ticksPerBeat = primary.ticksPerBar / ticksPerBar

            height: 75
        }

        SpinBox{
            id: bpmSpinBox

            Layout.alignment: Qt.AlignHCenter

            from: 1
            to: 300
            value: 80

            //textFromValue TODO: make it text editable
        }

        Button{
            Layout.alignment: Qt.AlignHCenter
            property bool running: false

            text: running ? "stop" : "start"

            onClicked:{
                running = !running
                if(running){
                    primary.startTimer()
                    secondary.startTimer()
                }
                else{
                    primary.stopTimer()
                    secondary.stopTimer()
                }
            }
        }
    }





    Popup {
        id: popup
        x: 100
        y: 100

        width: parent.width - 2 * x
        height: parent.height - 2 * y

        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        Text{
            anchors.fill: parent
            wrapMode: Text.WordWrap
            text: "The sourscode of the is available under https://github.com/tobeneck/Polytronome. \n \n The metronome sound was made by Druminfected from freesound.org (freesound.org/people/Druminfected/sounds/250551/). "
        }
    }

}
