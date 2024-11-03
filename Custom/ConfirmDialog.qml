import QtQuick 6.8

Window {
  id: confirmDialog

  signal clickedYes

  property alias dialogText: confirmDialogText.text

  title: qsTr("Confirm")
  color: Style.backgroundColor
  flags: Qt.Dialog
  modality: Qt.WindowModal

  width: 450
  height: 150

  Text {
    id: confirmDialogText

    wrapMode: Text.WordWrap
    anchors.centerIn: parent
    text: ""

    color: Style.textColor
    font.pointSize: 12
  }

  Row{
    spacing: 4

    anchors{
      top: confirmDialogText.bottom
      topMargin: 5

      right: parent.right
      rightMargin: 5
    }

    CustomButton{
      id: yesButton

      text: qsTr("Yes")
      width: 50
      buttonColor: Style.denyButtonColor
      onClicked: confirmDialog.clickedYes()
    }

    CustomButton{
      text: qsTr("No")
      width: 50
      buttonColor: Style.generalButtonColor
      onClicked: confirmDialog.close()
    }
  }
}
