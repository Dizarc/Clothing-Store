import QtQuick 6.6

Rectangle {
  id: myInputBox

  property alias echo: myTextInput.echoMode
  property alias text: myTextInput.text

  implicitWidth: 300
  implicitHeight: 25

  color: Style.inputBoxColor
  border.color: Style.borderColor
  border.width: 1
  radius: 5

  TextInput {
    id: myTextInput

    anchors.fill: parent

    leftPadding: 5

    activeFocusOnTab: true

    color: Style.textColor
    font.pointSize: 12
    maximumLength: 25
  }

  MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.NoButton
    cursorShape: Qt.IBeamCursor
  }

}
