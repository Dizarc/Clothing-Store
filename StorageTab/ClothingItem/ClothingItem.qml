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
import com.company.SizesModel
import com.company.ClothesTypesModel

Item {
  id: clothingItem

  property int clothingId
  property string clothingName
  property string clothingDescription
  property string clothingImageSource
  property int type

  property alias textState: clothesOutputText.state

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
            clothingItem.textState = "successRename"
          else
            clothingItem.textState = "failedRename"

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
          clothingItem.textState = "successDescriptionChange"
        else
          clothingItem.textState = "failedDescriptionChange"

        visible = false
      }
    }

    Row{
      spacing: 5

      Text{
        text: qsTr("Type:")
        font.pointSize: 12
        color: Style.textColor
      }

      ComboBox {
        id: typesComboBox

        width: 125
        height: 25

        font.pointSize: 12

        currentIndex: -1

        model: ClothesTypesModel

        delegate: ItemDelegate {
          id: cbDelegate

          required property int typeId
          required property string typeName

          required property int index

          width: typesComboBox.width
          height: typesComboBox.height

          contentItem: Text {
            text: typeName
            color: Style.textColor
            font: typesComboBox.font
            verticalAlignment: Text.AlignVCenter
          }

          background: Rectangle {
            color: cbDelegate.pressed ? Qt.lighter(
                                               Style.generalButtonColor,
                                               1.2) : cbDelegate.hovered ? Qt.lighter(Style.inputBoxColor, 1.1) : Style.inputBoxColor
            border.color: Style.borderColor
            radius: 2
          }

          highlighted: typesComboBox.highlightedIndex === index

          onClicked: {
            typesComboBox.displayText = typeName

            if(ClothesModel.reassignClothes(type, typeId, clothingId))
              clothingItem.textState = "successTypeChange"
            else
              clothingItem.textState = "failedTypeChange"
          }
        }

        contentItem: Text {
          leftPadding: 2
          rightPadding: typesComboBox.indicator.width + typesComboBox.spacing
          text: typesComboBox.displayText
          font: typesComboBox.font
          color: Style.textColor
          verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
          color: typesComboBox.pressed ? Qt.lighter(
                                     Style.inputBoxColor,
                                     1.2) : typesComboBox.hovered ? Qt.lighter(
                                                                Style.inputBoxColor,
                                                                1.1) : Style.inputBoxColor
          border.color: Style.borderColor
          radius: 2
        }

        popup: Popup {
          y: typesComboBox.height - 1
          width: typesComboBox.width
          implicitHeight: contentItem.implicitHeight
          padding: 1

          contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: typesComboBox.popup.visible ? typesComboBox.delegateModel : null
            currentIndex: typesComboBox.highlightedIndex
            ScrollIndicator.vertical: ScrollIndicator {}
          }

          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.NoButton
          }
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          acceptedButtons: Qt.NoButton
        }
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
                                                   1.4) : sizesViewDelegate.hovered ? Qt.lighter(Style.generalButtonColor, 1.2) : Style.generalButtonColor
          border.color: Style.borderColor
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
      CustomButton {
        text: qsTr("Add new size")

        buttonColor: Style.generalButtonColor

        onClicked: {
            SizesModel.filterAvailableSizes(clothingItem.clothingId)

            var component = Qt.createComponent("ClothingSizeAdd.qml")
            var window = component.createObject(clothingItem, {cId: clothingItem.clothingId})
            window.show()
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
            clothingItem.textState = "successChangeCount"
            sizesView.sizeCount += addSpinBox.value
          }else
            clothingItem.textState = "failedChangeCount"

          sizesView.currentIndex = -1
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
            sizesView.sizeCount += (-1)*removeSpinBox.value

            if(sizesView.sizeCount === 0){
              if(ClothesSizesModel.removeClothingSize(clothingId, sizesView.currentIndex))
                clothingItem.textState = "successChangeCount"
              else
                clothingItem.textState = "failedChangeCount"

            }else
              clothingItem.textState = "successChangeCount"

          }else
            clothingItem.textState = "failedChangeCount"

          sizesView.currentIndex = -1
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
        clothingItem.textState = "successImageChange"
      else
        clothingItem.textState = "failedImageChange"
    }
  }
}
