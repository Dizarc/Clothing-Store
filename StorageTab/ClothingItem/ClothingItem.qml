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
      height: parent.height / 2

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

    Row {
      id: sizingRow

      property int sizeCount: 0

      spacing: 5

      Text {
        text: qsTr("Size:")
        font.pointSize: 12
        color: Style.textColor
      }

      ComboBox {
        id: control

        width: 125
        height: 25

        currentIndex: -1

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
            verticalAlignment: Text.AlignVCenter
          }

          background: Rectangle {
            color: controlDelegate.pressed ? Qt.lighter(
                                               Style.generalButtonColor,
                                               1.2) : controlDelegate.hovered ? Qt.lighter(Style.inputBoxColor, 1.1) : Style.inputBoxColor
            border.color: Style.borderColor
            radius: 2
          }

          highlighted: control.highlightedIndex === index

          onClicked: {
            control.displayText = sizeId
            sizeInfoText.text = qsTr(
                  "Available: " + "<b>" + controlDelegate.count + "</b>")
            sizingRow.sizeCount = controlDelegate.count
          }
        }

        contentItem: Text {
          leftPadding: 2
          rightPadding: control.indicator.width + control.spacing

          text: control.displayText
          font: control.font

          color: Style.textColor
          verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
          color: control.pressed ? Qt.lighter(
                                     Style.inputBoxColor,
                                     1.2) : control.hovered ? Qt.lighter(
                                                                Style.inputBoxColor,
                                                                1.1) : Style.inputBoxColor
          border.color: Style.borderColor
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

      Text {
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

        from: sizingRow.sizeCount === 0 ? 0 : 1
        to: sizingRow.sizeCount
      }
    }
  }
}
