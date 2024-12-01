import QtQuick 6.8
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick.Dialogs
import QtCore

import "../../Custom"

import com.company.ClothesSizesModel
import com.company.ClothesModel
import com.company.SizesModel
import com.company.ClothesTypesModel
import com.company.LogData

Item {
  id: clothingItem

  property int clothingId
  property string clothingName
  property string clothingDescription
  property string clothingImageSource
  property int type

  Text {
    id: hoverText

    anchors {
      top: parent.top
      horizontalCenter: imageView.horizontalCenter
    }

    color: Style.textColor
    text: qsTr("pick a new image")
    font.pointSize: 14
    opacity: 0.0
  }

  MouseArea {
    id: imageView

    width: parent.width / 2
    height: parent.height - hoverText.height

    anchors.top: hoverText.bottom
    anchors.topMargin: 5

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

    Image {
      id: itemImage

      source: clothingImageSource !== "" ? "file:/" + clothingImageSource : ""
      visible: clothingImageSource !== ""
      width: parent.width
      fillMode: Image.PreserveAspectFit
    }
  }

  Column {
    width: clothingItem.width - imageView.width
    height: clothingItem.height

    anchors.left: imageView.right
    anchors.top: parent.top

    spacing: 10

    Row {
      spacing: 5

      CustomInputBox {
        id: nameInput

        text: clothingName
        font.pointSize: 15
        font.bold: true

        focus: true

        onTextChanged: {
          if (saveNameInputButton.visible !== true && text !== clothingName)
            saveNameInputButton.visible = true
        }
      }

      CustomButton {
        id: saveNameInputButton

        text: qsTr("Save name")

        width: 75
        buttonColor: Style.acceptButtonColor
        visible: false

        onClicked: {
          if (ClothesModel.rename(clothingId, nameInput.text)){
            storageInfoDialog.dialogText = qsTr("Successfully renamed clothing!")
            visible = false
          }else
            storageInfoDialog.dialogText = qsTr("Error while renaming clothing!")

          storageInfoDialog.show()
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
          if (saveDescriptionInputButton.visible !== true
              && text !== clothingDescription)
            saveDescriptionInputButton.visible = true
        }
      }
    }

    CustomButton {
      id: saveDescriptionInputButton
      text: qsTr("Save Description")

      buttonColor: Style.acceptButtonColor
      visible: false

      onClicked: {
        if (ClothesModel.changeDescription(clothingId, clothingTextArea.text)){
          storageInfoDialog.dialogText = qsTr("Successfully changed description!")
          visible = false
        }else
          storageInfoDialog.dialogText = qsTr("Error while changing description!")

        storageInfoDialog.show()
      }
    }

    Row {
      spacing: 5

      Text {
        text: qsTr("Type:")
        font.pointSize: 12
        color: Style.textColor
      }

      CustomComboBox {
        id: typesComboBox

        currentIndex: -1

        model: ClothesTypesModel

        delegate: ItemDelegate {
          id: cbDelegate

          required property int typeId
          required property string typeName

          required property int index

          width: typesComboBox.width
          implicitHeight: typesComboBox.height

          highlighted: typesComboBox.highlightedIndex === index

          contentItem: Text {
            text: typeName
            color: Style.textColor
            font: typesComboBox.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
          }

          background: Rectangle {
            color: cbDelegate.pressed ? Qt.lighter(
                                          Style.generalButtonColor,
                                          1.2) : cbDelegate.hovered ? Qt.lighter(
                                                                        Style.inputBoxColor,
                                                                        1.1) : Style.inputBoxColor
            border.color: Style.borderColor
            radius: 2
          }

          onClicked: {
            typesComboBox.displayText = typeName

            if (ClothesModel.reassignClothes(type, typeId, clothingId)) {
              storageInfoDialog.dialogText = qsTr("Successfully changed clothing type!")
              type = typeId
            }else
              storageInfoDialog.dialogText = qsTr("Error while changing clothing type!")

            storageInfoDialog.show()
          }
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
      //since we use QSqlRelationalTableModel the sizeId becomes the name of the size
      property string sizeSelected: ""

      width: parent.width
      height: 80
      cellWidth: 70
      cellHeight: 60

      currentIndex: -1

      clip: true
      flickableDirection: Flickable.VerticalFlick
      boundsBehavior: Flickable.StopAtBounds
      ScrollIndicator.vertical: ScrollIndicator {
        id: myScroll2
        contentItem: Rectangle {
          implicitWidth: 3
          radius: 5
          color: myScroll2.active ? Style.textColor : "transparent"
        }
      }

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

        contentItem: ColumnLayout {
          Layout.alignment: Qt.AlignHCenter
          Text {
            text: sizeId
            width: sizesViewDelegate.width
            color: Style.textColor
            font.pointSize: 10
            clip: true
          }
          Text {
            text: "count: " + "<b>" + count + "</b>"
            color: Style.textColor
            font.pointSize: 10
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
        SizesModel.filterAvailable(clothingItem.clothingId)

        var component = Qt.createComponent("ClothingSizeAdd.qml")
        var window = component.createObject(clothingItem, { "cId": clothingItem.clothingId })
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
          if (ClothesSizesModel.changeCount(clothingId, sizesView.sizeSelected, sizesView.sizeCount + addSpinBox.value)) {
            storageInfoDialog.dialogText = qsTr("Successfully changed clothing count!")

            sizesView.sizeCount += addSpinBox.value

            LogData.log(clothingId, type, sizesView.sizeSelected, sizesView.sizeCount);
          }else
            storageInfoDialog.dialogText = qsTr("Error while changing clothing count!")

          storageInfoDialog.show()
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

          if (ClothesSizesModel.changeCount(clothingId, sizesView.sizeSelected, sizesView.sizeCount + (-1) * removeSpinBox.value)) {
            sizesView.sizeCount += (-1) * removeSpinBox.value

            LogData.log(clothingId, type, sizesView.sizeSelected, sizesView.sizeCount);

            if (sizesView.sizeCount === 0) {
              if (ClothesSizesModel.remove(clothingId, sizesView.currentIndex)){
                storageInfoDialog.dialogText = qsTr("Successfully changed clothing count!")

                LogData.log(clothingId, type, sizesView.sizeSelected, 0);
              }else
                storageInfoDialog.dialogText = qsTr("Error while changing clothing count!")
            }else
              storageInfoDialog.dialogText = qsTr("Successfully changed clothing count!")
          }else
            storageInfoDialog.dialogText = qsTr("Error while changing clothing count!")

          storageInfoDialog.show()
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

    CustomButton {
      text: qsTr("Delete Item")

      buttonColor: Style.denyButtonColor

      enabled: isAdminLogged
      opacity: isAdminLogged ? 1 : 0.5

      onClicked: {
        deleteItemDialog.show()
      }
    }
  }

  ConfirmDialog {
    id: deleteItemDialog

    property int id: -1

    dialogText: qsTr("Are you sure you want to delete this Item?")

    onClickedYes: {
      if (ClothesModel.remove(clothingId)) {
        storageView.pop()
        storageInfoDialog.dialogText = qsTr("Successfully deleted clothing!")
      } else
        storageInfoDialog.dialogText = qsTr("Error while deleting clothing!")

      deleteItemDialog.close()
      storageInfoDialog.show()
    }
  }

  FileDialog {
    id: imageChoiceFileDialog

    title: qsTr("Select an Image")
    nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp)"]
    currentFolder: StandardPaths.standardLocations(
                     StandardPaths.DocumentsLocation)[0] + "/SeamlessManagerDocuments/"

    onAccepted: {
      if (ClothesModel.changeImage(clothingId, selectedFile)) {
        storageInfoDialog.dialogText = qsTr("Successfully changed clothing image!")

        clothingItem.clothingImageSource = selectedFile.toString().replace(
              "file:///", "")
      } else
        storageInfoDialog.dialogText = qsTr("Error while changing clothing image!")

      storageInfoDialog.show()
    }
  }
}
