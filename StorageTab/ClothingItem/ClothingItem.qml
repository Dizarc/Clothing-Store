import QtQuick 6.6
import QtQuick.Controls.Basic
import QtQuick.Layouts

import "../ClothesTypes"
import "../Clothes"
import "../"
import "../../Custom"

import com.company.ClothesSizesModel

Item {
  id: clothingItem

  property string clothingId
  property string clothingName
  property string clothingDescription
  property string clothingImageSource

  StorageTabInfoText {
    id: clothesOutputText
  }

  Image {
    id: imageView

    source: clothingImageSource !== "" ? "file:/" + clothingImageSource : ""
    visible: clothingImageSource !== ""

    anchors.top: clothesOutputText.bottom
    width: parent.width / 3

    fillMode: Image.PreserveAspectFit
  }

  Column {
    width: clothingItem.width - imageView.width
    height: clothingItem.height

    anchors.left: imageView.right
    anchors.top: parent.top

    spacing: 5

    Text {
      text: clothingName
      font.pointSize: 18
      color: Style.textColor
    }

    ScrollView {
      id: scrollView

      ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
      ScrollBar.vertical.policy: ScrollBar.AlwaysOn

      width: parent.width / 2
      height: parent.height / 3

      TextArea {
        readOnly: !isAdminLogged

        text: clothingDescription
        font.pointSize: 12
        color: Style.textColor

        background: Rectangle {
          color: Style.inputBoxColor
          border.color: Style.borderColor
          radius: 3
        }
      }
    }
    Row{
      spacing: 5

      Text{
        text: qsTr("Size:")
        font.pointSize: 12
        color: Style.textColor
      }

      ComboBox {
        id: control

        width: 125
        height: 25

        editable: isAdminLogged

        font.pointSize: 12

        model: ClothesSizesModel

        delegate: ItemDelegate {
          id: controlDelegate

          required property string clothingId
          required property string sizeId
          required property string count

          required property int index

          width: control.width
          height: control.height

          contentItem: Text {
            text: sizeId
            color: Style.textColor
            font: control.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
          }

          background: Rectangle {
            border.color: Style.borderColor
            color:  controlDelegate.pressed ? Qt.lighter(Style.generalButtonColor, 1.1) : Style.generalButtonColor
            radius: 2
          }

          highlighted: control.highlightedIndex === index

          onClicked: {
            control.displayText = sizeId
            sizeInfoText.text = qsTr("Available: " + controlDelegate.count)
          }
        }

        contentItem: Text {
          leftPadding: 2
          rightPadding: control.indicator.width + control.spacing

          text: control.displayText
          font: control.font

          color: Style.textColor
          verticalAlignment: Text.AlignVCenter
          elide: Text.ElideRight
        }

        background: Rectangle {
          implicitWidth: 100
          implicitHeight: 25
          border.color: Style.borderColor
          color: Style.inputBoxColor
          border.width: control.visualFocus ? 2 : 1
          radius: 2
        }

        popup: Popup {
          y: control.height - 1
          width: control.width
          implicitHeight: contentItem.implicitHeight
          padding: 1

          contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator {}
          }
        }
      }

      Text{
        id: sizeInfoText

        text: qsTr("No size selected")
        font.pointSize: 12
        color: Style.textColor
      }

    }

    Row {
      spacing: 5

      CustomButton {
        text: qsTr("Add")

        buttonColor: Style.acceptButtonColor

        //onClicked:
      }

      CustomButton {
        text: qsTr("Sell")

        buttonColor: Style.denyButtonColor

        //onClicked:
      }
    }
  }
}
