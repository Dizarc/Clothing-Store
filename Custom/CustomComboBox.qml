import QtQuick 6.8
import QtQuick.Controls.Basic

ComboBox {
  id: customCb

  implicitWidth: 150
  implicitHeight: 25

  font.pointSize: 12

  contentItem: Text {
    leftPadding: 5
    rightPadding: customCb.indicator.width + customCb.spacing

    text: customCb.displayText
    font: customCb.font
    color: customCb.pressed ? Qt.lighter(Style.textColor, 1.1) : Style.textColor

    verticalAlignment: Text.AlignVCenter
  }

  background: Rectangle {
    color: customCb.pressed ? Qt.lighter(
                                     Style.inputBoxColor,
                                     1.2) : customCb.hovered ? Qt.lighter(
                                                                      Style.inputBoxColor,
                                                                      1.1) : Style.inputBoxColor
    border.color: Style.borderColor
    border.width: customCb.visualFocus ? 2 : 1
    radius: 2
  }

  popup: Popup {
    y: customCb.height - 2
    width: customCb.width
    implicitHeight: contentItem.implicitHeight

    padding: 1

    contentItem: ListView {
      clip: true
      implicitHeight: contentHeight
      model: customCb.popup.visible ? customCb.delegateModel : null
      currentIndex: customCb.highlightedIndex
    }

    background: Rectangle {
      color: Style.inputBoxColor
      border.color: Style.borderColor
      radius: 2
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
