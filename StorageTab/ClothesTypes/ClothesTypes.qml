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

  CustomButton {
    id: addTypesButton

    enabled: isAdminLogged
    opacity: isAdminLogged ? 1 : 0.5

    text: qsTr("Add a new type")
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

    flickableDirection: Flickable.VerticalFlick
    boundsBehavior: Flickable.StopAtBounds

    model: ClothesTypesModel

    delegate: ClothesTypesDelegate { }
  }

  CustomEditingDialog{
    id: deleteClothesTypesDialog

    title: qsTr("Are you sure you want to delete this type?"
                + "\nEvery clothing inside this type will become \"uncategorized\"")

    onAccepted: {
      if(ClothesTypesModel.deleteType(id))
       clothesTypesColumn.textState = "successDelete"
      else
       clothesTypesColumn.textState = "failedDelete"

      deleteClothesTypesDialog.close()
    }
  }

  CustomEditingDialog {
    id: renameClothesTypesDialog

    title: qsTr("Rename type:")

    onAccepted: {
      if(ClothesTypesModel.renameType(id, typeNameInput.text))
       clothesTypesColumn.textState = "successRename"
      else
       clothesTypesColumn.textState = "failedRename"

      renameClothesTypesDialog.close()
    }

    Column{
      anchors.fill: parent
      spacing: 5

      Text {
        text: qsTr("Enter type name:")

        color: Style.textColor
        font.pointSize: 12
      }

      CustomInputBox{
        id: typeNameInput
      }
    }
  }

  CustomEditingDialog {
    id: changeImageClothesTypesDialog

    title: qsTr("Change image for this type:")

    onAccepted: {
      if(ClothesTypesModel.changeTypeImage(id, changeTypeImage.source))
       clothesTypesColumn.textState = "successImageChange"
      else
       clothesTypesColumn.textState = "failedImageChange"

      changeImageClothesTypesDialog.close()
    }

    Column{
      anchors.fill: parent
      spacing: 5

      Text{
        anchors.horizontalCenter: parent.horizontalCenter
        color: Style.textColor
        text: qsTr("Pick an image:")
        font.pointSize: 12
      }

      Rectangle{
        id: changeImageRect
        width: 300
        height: 300

        anchors.horizontalCenter: parent.horizontalCenter

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
