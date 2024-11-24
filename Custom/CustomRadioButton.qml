import QtQuick 6.8
import QtQuick.Controls.Basic

RadioButton {
  id: myRb

  font.pointSize: 12

  indicator: Rectangle {
    implicitWidth: 20
    implicitHeight: 20
    x: myRb.leftPadding
    y: parent.height / 2 - height / 2

    radius: 13
    color: myRb.down ? Qt.lighter(Style.generalButtonColor, 1.3)
                     : (myRb.hovered ? Qt.lighter(Style.generalButtonColor, 1.1)
                                     : Style.generalButtonColor)
    border.color: Style.borderColor

    Rectangle {
      width: 12
      height: 12
      x: 4
      y: 4

      radius: 7
      color: Style.textColor
      visible: myRb.checked
    }
  }

  contentItem: Text {
    text: myRb.text
    font: myRb.font

    color: Style.textColor

    verticalAlignment: Text.AlignVCenter
    leftPadding: myRb.indicator.width + myRb.spacing
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    acceptedButtons: Qt.NoButton
  }
}
