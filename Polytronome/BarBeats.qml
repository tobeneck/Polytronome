import QtQuick 2.0
import QtQuick.Controls 2.12 //for the spinBox
import QtMultimedia 5.12 //for SoundEffect

Item {

    property double ticksPerBeat: 1.0
    property int ticksPerBar: 4

    property int tempo

    function startTimer(){
        timer.start()
    }

    function stopTimer(){
        timer.stop()
    }

    Timer{
        id: timer
        repeat: true
        interval: (60000 / tempo) * ticksPerBeat
        running: false
        triggeredOnStart: false

        onTriggered: klickSound.play()

    }

    SoundEffect{
        //sound from Druminfected on freesound.org: https://freesound.org/people/Druminfected/sounds/250551/

        id: klickSound
        source: "klick.wav"
    }

    SpinBox{
        id: beatsPerBarSpinBox

        anchors.centerIn: parent

        from: 1
        value: 4

        onValueChanged: {
            ticksPerBar = value
        }


        editable: true

        //textFromValue TODO: make it text editable
    }

}
