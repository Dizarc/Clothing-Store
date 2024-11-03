import QtQuick 6.8

Rectangle {
  id: myInputBox

  property alias echo: myTextInput.echoMode
  property alias text: myTextInput.text
  property alias font: myTextInput.font

  implicitWidth: 300
  implicitHeight: 25

  color: Style.inputBoxColor
  border.color: Style.borderColor
  border.width: 1
  radius: 5

  TextInput {
    id: myTextInput

    anchors.fill: parent

    clip: true
    leftPadding: 5
    rightPadding: 5

    activeFocusOnTab: true

    color: Style.textColor
    font.pointSize: 12
    maximumLength: 45
  }

  MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.NoButton
    cursorShape: Qt.IBeamCursor
  }
}
