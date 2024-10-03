import QtQuick 6.6
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick.Dialogs
import QtCore

import "../ClothesTypes"
import "../Clothes"
import "../"
import "../../Custom"

import com.company.ClothesSizesModel
import com.company.ClothesModel

Item {
  id: clothingItem

  property string clothingId
  property string clothingName
  property string clothingDescription
  property string clothingImageSource

  StorageTabInfoText {
    id: clothesOutputText
  }

  Text {
    id: hoverText

    anchors {
      top: clothesOutputText.bottom
      topMargin: 10
      horizontalCenter: imageView.horizontalCenter
    }

    color: Style.textColor
    text: qsTr("pick a new image")
    font.pointSize: 14
    opacity: 0.0
  }

  Image {
    id: imageView

    source: clothingImageSource !== "" ? "file:/" + clothingImageSource : ""
    visible: clothingImageSource !== ""

    anchors.top: hoverText.bottom
    anchors.topMargin: 5

    width: parent.width / 2

    fillMode: Image.PreserveAspectFit

    MouseArea {
      anchors.fill: parent

      enabled: isAdminLogged

      cursorShape: Qt.PointingHandCursor
      hoverEnabled: true

      onClicked: imageChoiceFileDialog.open()

      onEntered: {
        hoverText.opacity = 1.0
        imageView.opacity = 0.7
      }

      onExited: {
        hoverText.opacity = 0.0
        imageView.opacity = 1.0
      }
    }
  }

  Column {
    width: clothingItem.width - imageView.width
    height: clothingItem.height

    anchors.left: imageView.right
    anchors.top: parent.top

    spacing: 5

    Row{
      spacing: 5

      CustomInputBox {
        id: nameInput
        text: clothingName
        font.pointSize: 15
        font.bold: true

        focus: true

        onTextChanged: {
          if(saveNameInputButton.visible !== true && text !== clothingName )
            saveNameInputButton.visible = true
        }
      }

      CustomButton{
        id: saveNameInputButton
        text: qsTr("Save name")

        width: 75
        buttonColor: Style.acceptButtonColor
        visible: false

        onClicked: {
          if(ClothesModel.renameClothing(clothingId, nameInput.text))
            clothesOutputText.state = "successRename"
          else
            clothesOutputText.state = "failedRename"

          visible = false
        }
      }
    }


    ScrollView {
      id: scrollView

      ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
      ScrollBar.vertical.policy: ScrollBar.AlwaysOn

      width: parent.width / 1.5
      height: parent.height / 3

      TextArea {
        id: clothingTextArea

        readOnly: !isAdminLogged
        wrapMode: Text.WordWrap
        text: clothingDescription
        font.pointSize: 12
        color: Style.textColor

        background: Rectangle {
          color: Style.inputBoxColor
          border.color: Style.borderColor
          radius: 3
        }

        onTextChanged: {
          if(saveDescriptionInputButton.visible !== true && text !== clothingDescription )
            saveDescriptionInputButton.visible = true
        }
      }
    }

    CustomButton{
      id: saveDescriptionInputButton
      text: qsTr("Save Description")

      buttonColor: Style.acceptButtonColor
      visible: false

      onClicked: {
        if(ClothesModel.changeClothingDescription(clothingId, clothingTextArea.text))
          clothesOutputText.state = "successDescriptionChange"
        else
          clothesOutputText.state = "failedDescriptionChange"

        visible = false
      }
    }

    Text {
      text: qsTr("Sizes:")
      font.pointSize: 12
      color: Style.textColor
    }

    GridView {
      id: sizesView

      property int sizeCount: 0
      property string sizeSelected: ""

      width: parent.width
      height: 80
      cellWidth: 65
      cellHeight: 60

      currentIndex: -1

      flickableDirection: Flickable.VerticalFlick
      boundsBehavior: Flickable.StopAtBounds

      model: ClothesSizesModel

      delegate: ItemDelegate {
        id: sizesViewDelegate

        required property string sizeId
        required property int count

        required property int index

        width: sizesView.cellWidth - 4
        height: sizesView.cellHeight - 4

        focus: true

        highlighted: sizesView.currentIndex === index

        onClicked: {
          sizesView.currentIndex = index
          sizesView.sizeCount = count
          sizesView.sizeSelected = sizeId
        }

        background: Rectangle {
          color: sizesViewDelegate.highlighted ? Qt.darker(
                                                   Style.generalButtonColor,
                                                   1.2) : sizesViewDelegate.hovered ? Qt.lighter(Style.inputBoxColor, 1.1) : Style.inputBoxColor
          border.color: Style.borderColor
          radius: 1
        }

        contentItem: Column {
          Text {
            text: sizeId
            color: Style.textColor
            font.pointSize: 10
            anchors.horizontalCenter: parent.horizontalCenter
          }
          Text {
            text: "count: " + "<b>" + count + "</b>"
            color: Style.textColor
            font.pointSize: 10
            anchors.horizontalCenter: parent.horizontalCenter
          }
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          acceptedButtons: Qt.NoButton
        }
      }
    }

    Row {
      spacing: 3

      CustomButton {
        id: sizeInfoText

        text: qsTr("Add new size")
        buttonColor: Style.generalButtonColor

        onClicked: {
          newSizeText.visible = true
          sizesCb.visible = true
        }
      }

      Text {
        id: newSizeText

        visible: false
        text: qsTr("select new size: ")
        font.pointSize: 12
        color: Style.textColor
      }

      SizesComboBox {
        id: sizesCb
        visible: false
      }
    }

    Row {
      spacing: 5

      CustomButton {
        text: qsTr("Add")

        buttonColor: Style.acceptButtonColor

        enabled: sizesView.currentIndex !== -1
        opacity: sizesView.currentIndex === -1 ? 0.5 : 1

        onClicked: {
          if(ClothesSizesModel.changeCount( clothingId, sizesView.sizeSelected, addSpinBox.value)){
            clothesOutputText.state = "successChangeCount"
            sizesView.sizeCount += addSpinBox.value
          }else
            clothesOutputText.state = "failedChangeCount"
        }
      }

      Text {
        text: qsTr("count: ")
        font.pointSize: 12
        color: Style.textColor
      }

      CustomSpinBox {
        id: addSpinBox
      }
    }

    Row {
      spacing: 5

      CustomButton {
        text: qsTr("Remove")

        buttonColor: Style.denyButtonColor

        enabled: sizesView.currentIndex !== -1
        opacity: sizesView.currentIndex === -1 ? 0.5 : 1

        onClicked: {
          if(ClothesSizesModel.changeCount(clothingId, sizesView.sizeSelected, (-1)*removeSpinBox.value)){
            clothesOutputText.state = "successChangeCount"
            sizesView.sizeCount += (-1)*removeSpinBox.value
            //removeSpinBox.value = 0
          }else
            clothesOutputText.state = "failedChangeCount"
        }
      }

      Text {
        text: qsTr("count: ")
        font.pointSize: 12
        color: Style.textColor
      }

      CustomSpinBox {
        id: removeSpinBox

        from: sizesView.sizeCount === 0 ? 0 : 1
        to: sizesView.sizeCount
      }
    }
  }

  FileDialog {
    id: imageChoiceFileDialog
    title: qsTr("Select an Image")

    nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp)"]
    currentFolder: StandardPaths.standardLocations(
                     StandardPaths.DocumentsLocation)[0] + "/ClothingStoreDocuments/"
    onAccepted: {
      imageView.source = selectedFile
      if (ClothesModel.changeClothingImage(clothingId, imageView.source))
        clothesOutputText.state = "successImageChange"
      else
        clothesOutputText.state = "failedImageChange"
    }
  }
}
