import QtQuick 6.6
import QtQuick.Controls.Basic

import "../ClothesTypes"
import "../Clothes"
import "../"
import "../../Custom"

import com.company.ClothesSizesModel

ComboBox {
  id: sizesComboBox

  width: 125
  height: 25

  currentIndex: -1

  font.pointSize: 12

  model: ClothesSizesModel

  delegate: ItemDelegate {
    id: cbDelegate

    required property string clothingId
    required property string sizeId
    required property string count

    required property int index

    width: sizesComboBox.width
    height: sizesComboBox.height

    contentItem: Text {
      text: sizeId
      color: Style.textColor
      font: sizesComboBox.font
      verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
      color: cbDelegate.pressed ? Qt.lighter(
                                         Style.generalButtonColor,
                                         1.2) : cbDelegate.hovered ? Qt.lighter(Style.inputBoxColor, 1.1) : Style.inputBoxColor
      border.color: Style.borderColor
      radius: 2
    }

    highlighted: sizesComboBox.highlightedIndex === index

    onClicked: {
      sizesComboBox.displayText = sizeId
    }
  }

  contentItem: Text {
    leftPadding: 2
    rightPadding: sizesComboBox.indicator.width + sizesComboBox.spacing

    text: sizesComboBox.displayText
    font: sizesComboBox.font

    color: Style.textColor
    verticalAlignment: Text.AlignVCenter
  }

  background: Rectangle {
    color: sizesComboBox.pressed ? Qt.lighter(
                               Style.inputBoxColor,
                               1.2) : sizesComboBox.hovered ? Qt.lighter(
                                                          Style.inputBoxColor,
                                                          1.1) : Style.inputBoxColor
    border.color: Style.borderColor
    radius: 2
  }

  popup: Popup {
    y: sizesComboBox.height - 1
    width: sizesComboBox.width
    implicitHeight: contentItem.implicitHeight
    padding: 1

    contentItem: ListView {
      clip: true
      implicitHeight: contentHeight
      model: sizesComboBox.popup.visible ? sizesComboBox.delegateModel : null
      currentIndex: sizesComboBox.highlightedIndex

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

