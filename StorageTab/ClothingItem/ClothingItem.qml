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
        }
      }
    }

    ComboBox {
      id: control

      height: 25
      width: 100
      editable: isAdminLogged

      model: ClothesSizesModel

      delegate: ItemDelegate {

        required property string clothingId
        required property string sizeId

        required property int index

        width: control.width

        contentItem: Text {
          text: sizeId
          color: Style.textColor
          font: control.font
          elide: Text.ElideRight
          verticalAlignment: Text.AlignVCenter
        }

        highlighted: control.highlightedIndex === index
      }

      contentItem: Text {
        leftPadding: 0
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

        background: Rectangle {
          border.color: Style.borderColor
          color: Style.generalButtonColor
          radius: 2
        }
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
