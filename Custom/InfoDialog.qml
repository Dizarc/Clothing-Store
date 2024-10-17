import QtQuick 6.6

Window {
  id: infoDialogWindow

  property alias dialogText: infoDialogText.text

  title: qsTr("Information")
  width: 250
  height: 100
  color: Style.backgroundColor
  flags: Qt.Dialog
  modality: Qt.WindowModal

  onActiveChanged: {
    if (!infoDialogWindow.active)
      infoDialogWindow.close();
  }

  Text {
    id: infoDialogText

    anchors.centerIn: parent
    text: ""

    color: Style.textColor
    font.pointSize: 12
  }

  CustomButton{
    text: qsTr("Ok")
    width: 50

    buttonColor: Style.generalButtonColor

    anchors{
      top: infoDialogText.bottom
      topMargin: 5

      right: parent.right
      rightMargin: 5
    }

    onClicked: {
        infoDialogWindow.close()
    }
  }
}
