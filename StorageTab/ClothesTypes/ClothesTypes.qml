import QtQuick 6.6
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import QtCore

import "../../Custom"
import "../"

import com.company.ClothesTypesModel

ColumnLayout {
  id: clothesTypesColumn

  spacing: 5

  property alias textState: clothesTypesOutputText.state

  StorageTabInfoText{
    id: clothesTypesOutputText
  }

  InfoDialog {
    id: typeInfoDialog
  }

  CustomButton {
    id: addTypesButton

    enabled: isAdminLogged
    opacity: isAdminLogged ? 1 : 0.5

    text: qsTr("New type")
    buttonColor: Style.generalButtonColor

    onClicked: {
      var component = Qt.createComponent("ClothesTypesAdd.qml")
      var window = component.createObject()
      window.show()
    }
  }

  GridView {
    id: clothesTypesView

    Layout.fillWidth: true
    Layout.fillHeight: true

    cellWidth: 150
    cellHeight: 200

    clip: true
    flickableDirection: Flickable.VerticalFlick
    boundsBehavior: Flickable.StopAtBounds
    ScrollIndicator.vertical: ScrollIndicator {
      id: myScroll
      contentItem: Rectangle {
        implicitWidth: 2
        radius: 5
        color: myScroll.active ? Style.textColor : "transparent"
      }
    }

    model: ClothesTypesModel

    delegate: ClothesTypesDelegate { }
  }

  ConfirmDialog {
    id: deleteClothesTypesDialog

    property int id: -1

    dialogText: qsTr("Are you sure you want to delete this type?"
                     + "\nEvery clothing inside this type will become \"uncategorized\"")

    onClickedYes: {
      if(ClothesTypesModel.deleteType(deleteClothesTypesDialog.id))
        typeInfoDialog.dialogText = qsTr("Successfully deleted type!")
      else
        typeInfoDialog.dialogText = qsTr("Error while deleting type!")

        deleteClothesTypesDialog.close()
        typeInfoDialog.show()
    }
  }

  Window {
    id: renameClothesTypesDialog

    property int id: -1

    title: qsTr("Rename")
    color: Style.backgroundColor
    flags: Qt.Dialog
    modality: Qt.WindowModal

    width: 350
    height: 100

    Column{
      anchors.horizontalCenter: parent.horizontalCenter
      spacing: 5

      Text {
        text: qsTr("Enter type name:")

        color: Style.textColor
        font.pointSize: 12
      }

      CustomInputBox{
        id: typeNameInput
      }

      Row{
        spacing: 4

        CustomButton{
          text: qsTr("Change")
          width: 100

          buttonColor: Style.acceptButtonColor

          onClicked: {
            if(ClothesTypesModel.renameType(renameClothesTypesDialog.id, typeNameInput.text))
             clothesTypesColumn.textState = "successRename"
            else
             clothesTypesColumn.textState = "failedRename"

            renameClothesTypesDialog.close()
          }
        }

        CustomButton{
          text: qsTr("Cancel")
          width: 100
          buttonColor: Style.denyButtonColor
          onClicked: renameClothesTypesDialog.close()
        }
      }
    }
  }

  Window {
    id: changeImageClothesTypesDialog

    property int id: -1

    width: 350
    height: 400
    title: qsTr("Change Image")
    color: Style.backgroundColor
    flags: Qt.Dialog
    modality: Qt.WindowModal

    Column{
      anchors.horizontalCenter: parent.horizontalCenter
      spacing: 5

      Text{
        color: Style.textColor
        text: qsTr("Pick an image:")
        font.pointSize: 12
      }

      Rectangle{
        id: changeImageRect
        width: 300
        height: 300

        color: Style.inputBoxColor
        border.color: Style.borderColor
        border.width: 1

        radius: 5

        Image{
          id: changeTypeImage

          anchors.fill: parent

          source: ""
          sourceSize.width: changeImageRect.width - 6

          fillMode: Image.PreserveAspectFit
        }

        Text{
          id: changeHoverText
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

          onClicked: changeImageChoicefileDialog.open()

          onEntered: {
            changeHoverText.opacity = 1.0
            changeImageRect.opacity = 0.7
          }

          onExited: {
            changeHoverText.opacity = 0.0
            changeImageRect.opacity = 1.0
          }
        }
      }

      Row{
        spacing: 4

        CustomButton{
          text: qsTr("Change")
          width: 100

          buttonColor: Style.acceptButtonColor

          onClicked: {
            if(ClothesTypesModel.changeTypeImage(changeImageClothesTypesDialog.id, changeTypeImage.source))
             clothesTypesColumn.textState = "successImageChange"
            else
             clothesTypesColumn.textState = "failedImageChange"

            changeImageClothesTypesDialog.close()
          }
        }

        CustomButton{
          text: qsTr("Cancel")
          width: 100
          buttonColor: Style.denyButtonColor
          onClicked: changeImageClothesTypesDialog.close()
        }
      }
    }

    FileDialog{
      id: changeImageChoicefileDialog
      title: qsTr("Select an Image")

      nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp)"]
      currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0] + "/ClothingStoreDocuments/"

      onAccepted: changeTypeImage.source = selectedFile
    }
  }

}
