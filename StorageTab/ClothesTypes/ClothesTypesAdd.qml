import QtQuick 6.6
import QtQuick.Dialogs
import QtCore

import "../../Custom"

import com.company.ClothesTypesModel

Window {
  id: clothesTypeAddWindow

  title: "Add a new clothing type"

  flags: Qt.Dialog

  color: Style.backgroundColor

  height: 500
  width: 800

  onActiveChanged: {
    if (!clothesTypeAddWindow.active && !imageChoicefileDialog.visible)
      clothesTypeAddWindow.close();
  }

  Column{
    anchors.fill: parent

    spacing: 5

    Text{
      anchors.horizontalCenter: parent.horizontalCenter
      color: Style.textColor
      text: qsTr("Name of type:")
      font.pointSize: 12
    }

    CustomInputBox{
      id: typeNameInput
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
        id: typeImage

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

        onClicked: imageChoicefileDialog.open()

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
      id: saveTypeButton

      anchors.horizontalCenter: parent.horizontalCenter

      text: qsTr("Save")
      buttonColor: Style.acceptButtonColor
      onClicked: {
        if(ClothesTypesModel.addNewType(typeNameInput.text, typeImage.source)){
          clothesTypesTextState.state = "successCreated" //DOESNT WORK
          clothesTypeAddWindow.close()
        }
        else
          failedSaveText.visible = true
      }
    }

    Text {
      id: failedSaveText

      anchors.horizontalCenter: parent.horizontalCenter

      visible: false

      text: qsTr("Failed to save Type!")
      color: Style.denyButtonColor
      font.bold: true
    }
  }

  FileDialog{
    id: imageChoicefileDialog
    title: qsTr("Select an Image")

    nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp)"]
    currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0] + "/ClothingStoreDocuments/"
    onAccepted: typeImage.source = selectedFile
  }

}
