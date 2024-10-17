import QtQuick 6.6

Window {
  id: confirmDialog

  signal clickedYes

  property alias dialogText: confirmDialogText.text

  title: qsTr("Confirm")
  width: 450
  height: 150
  color: Style.backgroundColor
  flags: Qt.Dialog
  modality: Qt.WindowModal

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

      buttonColor: Style.generalButtonColor

      onClicked: confirmDialog.clickedYes()
    }

    CustomButton{
      text: qsTr("No")
      width: 50
      buttonColor: Style.denyButtonColor
      onClicked: confirmDialog.close()
    }
  }
}
