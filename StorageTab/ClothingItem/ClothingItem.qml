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
    width: parent.width / 2

    fillMode: Image.PreserveAspectFit
  }

  Column {
    width: clothingItem.width - imageView.width
    height: clothingItem.height

    anchors.left: imageView.right
    anchors.top: parent.top

    spacing: 10

    Text {
      text: clothingName
      font.pointSize: 18
      color: Style.textColor
    }

    ScrollView {
      id: scrollView

      ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
      ScrollBar.vertical.policy: ScrollBar.AlwaysOn

      width: parent.width / 1.5
      height: parent.height / 3

      TextArea {
        id: clothingTextArea

        readOnly: true
        wrapMode: Text.WordWrap
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

    Text {
      text: qsTr("Sizes:")
      font.pointSize: 12
      color: Style.textColor
    }

    GridView {
      id: control

      property int sizeCount: 0

      width: parent.width
      height: 80
      cellWidth: 65
      cellHeight: 60

      currentIndex: -1

      flickableDirection: Flickable.VerticalFlick
      boundsBehavior: Flickable.StopAtBounds

      model: ClothesSizesModel

      delegate: ItemDelegate {
        id: controlDelegate

        required property string clothingId
        required property string sizeId
        required property string count

        required property int index

        width: control.cellWidth - 4
        height: control.cellHeight - 4

        focus: true

        highlighted: control.currentIndex === index

        onClicked: {
          control.currentIndex = index
          control.sizeCount = count
        }

        background: Rectangle {
          color: controlDelegate.highlighted ? Qt.darker(
                                             Style.generalButtonColor,
                                             1.2) : controlDelegate.hovered ? Qt.lighter(Style.inputBoxColor, 1.1) : Style.inputBoxColor
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

    Row{
      spacing: 3

      CustomButton {
        id: sizeInfoText

        text: qsTr("Add new size")
        buttonColor: Style.generalButtonColor
      }

      Text{
        text: qsTr("select new size: ")
        font.pointSize: 12
        color: Style.textColor
      }

      SizesComboBox{

      }
    }

    Row {
      spacing: 5

      CustomButton {
        text: qsTr("Add")

        buttonColor: Style.acceptButtonColor

        enabled: control.currentIndex !== -1
        opacity: control.currentIndex === -1 ? 0.5 : 1

        //onClicked:
      }

      Text {
        text: qsTr("count: ")
        font.pointSize: 12
        color: Style.textColor
      }

      CustomSpinBox {}
    }

    Row {
      spacing: 5

      CustomButton {
        text: qsTr("Remove")

        buttonColor: Style.denyButtonColor

        enabled: control.currentIndex !== -1
        opacity: control.currentIndex === -1 ? 0.5 : 1

        //onClicked:
      }

      Text {
        text: qsTr("count: ")
        font.pointSize: 12
        color: Style.textColor
      }

      CustomSpinBox {
        id: removeSpinBox

        from: control.sizeCount === 0 ? 0 : 1
        to: control.sizeCount
      }
    }
  }
}
