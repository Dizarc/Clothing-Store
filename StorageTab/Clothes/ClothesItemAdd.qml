import QtQuick 6.6
import QtQuick.Dialogs
import QtCore

import "../../Custom"

import com.company.ClothesModel

Window {
  id: clothesItemAddWindow

  property int tId: -1

  title: "Add a new clothing item"

  flags: Qt.Dialog

  color: Style.backgroundColor

  height: 500
  width: 800

  onActiveChanged: {
    if (!clothesItemAddWindow.active && !imageChoiceFileDialog.visible)
      clothesItemAddWindow.close();
  }

  Column{
    anchors.fill: parent

    spacing: 5

    Text{
      anchors.horizontalCenter: parent.horizontalCenter
      color: Style.textColor
      text: qsTr("Name of item:")
      font.pointSize: 12
    }

    CustomInputBox{
      id: itemNameInput
      anchors.horizontalCenter: parent.horizontalCenter
    }

    Text{
      anchors.horizontalCenter: parent.horizontalCenter
      color: Style.textColor
      text: qsTr("Pick an image:")
      font.pointSize: 12
    }

    Rectangle{
      id: imageRect
      width: 300
      height: 300

      anchors.horizontalCenter: parent.horizontalCenter

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
      anchors.horizontalCenter: parent.horizontalCenter

      text: qsTr("Save")
      buttonColor: Style.acceptButtonColor
      onClicked: {
        if(ClothesModel.addNewClothing(itemNameInput.text, itemImage.source, clothesItemAddWindow.tId)){
          clothesColumn.clothesTextState = "successCreated"
          clothesItemAddWindow.close()
        }
        else{
          clothesColumn.clothesTextState = "failedCreated"
          clothesItemAddWindow.close()
        }
      }
    }
  }

  FileDialog{
    id: imageChoiceFileDialog
    title: qsTr("Select an Image")

    nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp)"]
    currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0] + "/ClothingStoreDocuments/"
    onAccepted: itemImage.source = selectedFile
  }
}
