import QtQuick 6.6
import QtQuick.Dialogs
import QtCore

import "../Custom"

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

    Rectangle {

      width: 300
      height: 25
      anchors.horizontalCenter: parent.horizontalCenter

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput {
        id: typeNameInput

        anchors.fill: parent

        leftPadding: 5

        activeFocusOnTab: true

        color: Style.textColor
        font.pointSize: 12
        maximumLength: 25
      }
    }

    Text{
      anchors.horizontalCenter: parent.horizontalCenter
      color: Style.textColor
      text: qsTr("Pick an image:")
      font.pointSize: 12
    }

    Rectangle{
      width: 75
      height: 100

      anchors.horizontalCenter: parent.horizontalCenter

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1

      radius: 5

      Image{
        id: typeImage

        anchors.fill: parent

        source: ""
        sourceSize.width: 50
        sourceSize.height: 70

        fillMode: Image.PreserveAspectFit
      }

      Text{
        id: hoverText

        color: Style.textColor
        text: qsTr("Click to open image")
        font.pointSize: 12
        opacity: 0.0
      }

      MouseArea{
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: imageChoicefileDialog.open()
      }
    }

    CustomButton {
      id: saveTypeButton

      anchors.horizontalCenter: parent.horizontalCenter

      text: qsTr("Save")
      buttonColor: Style.acceptButtonColor
      onClicked: {
        saveTypeOutputText.state = "successSave"
        clothesTypeAddWindow.close()
      }
    }

    Text {
      id: saveTypeOutputText

      anchors.horizontalCenter: parent.horizontalCenter

      text: qsTr("")
      font.bold: true

      states: [
        State {
          name: "nothing"
          PropertyChanges {
            buttonOutputText {
              text: qsTr("")
            }
          }
        },
        State {
          name: "successSave"
          PropertyChanges {
            saveTypeOutputText {
              text: qsTr("Saved type!")
              color: Style.acceptButtonColor
            }
          }
        },
        State {
          name: "failedSave"
          PropertyChanges {
            saveTypeOutputText {
              text: qsTr("Failed to save Type!")
              color: Style.denyButtonColor
            }
          }
        }
      ]
    }
  }

  FileDialog{
    id: imageChoicefileDialog
    title: qsTr("Select an Image")

    nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp)"]
    currentFolder: StandardPaths.standardLocations(StandardPaths.DesktopLocation)[0]

    onAccepted: typeImage.source = selectedFile
  }

}
