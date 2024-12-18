import QtQuick 6.8
import QtQuick.Dialogs
import QtCore

import "../../Custom"

import com.company.ClothesModel

Window {
  id: clothesItemAddWindow

  property int tId: -1

  title: qsTr("Add a new clothing item")
  flags: Qt.Dialog
  modality: Qt.WindowModal
  color: Style.backgroundColor

  width: 500
  height: 500

  Column{
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 5

    Text{
      color: Style.textColor
      text: qsTr("Name of item:")
      font.pointSize: 12
    }

    CustomInputBox{
      id: itemNameInput
    }

    Text{
      color: Style.textColor
      text: qsTr("Pick an image:")
      font.pointSize: 12
    }

    Rectangle{
      id: imageRect

      width: 300
      height: 300

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1

      radius: 5

      Image{
        id: itemImage

        anchors.fill: parent

        source: ""
        sourceSize.width: imageRect.width - 6

        fillMode: Image.PreserveAspectFit
      }

      Text{
        id: hoverText
        anchors.centerIn: parent
        color: Style.textColor
        text: qsTr("Click to open image")
        font.pointSize: 12
        opacity: 0.0
      }

      MouseArea{
        anchors.fill: parent

        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onClicked: imageChoiceFileDialog.open()

        onEntered: {
          hoverText.opacity = 1.0
          imageRect.opacity = 0.7
        }

        onExited: {
          hoverText.opacity = 0.0
          imageRect.opacity = 1.0
        }
      }
    }

    CustomButton {
      text: qsTr("Save")
      buttonColor: Style.acceptButtonColor

      onClicked: {
        if(ClothesModel.add(itemNameInput.text, itemImage.source, clothesItemAddWindow.tId))
          clothesInfoDialog.dialogText = qsTr("Successfully created new item!")
        else
          clothesInfoDialog.dialogText = qsTr("Error while creating new item!")

        clothesItemAddWindow.close()
        clothesInfoDialog.show()
      }
    }
  }

  FileDialog{
    id: imageChoiceFileDialog
    title: qsTr("Select an Image")

    nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp)"]
    currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0] + "/SeamlessManagerDocuments/"
    onAccepted: itemImage.source = selectedFile
  }
}
