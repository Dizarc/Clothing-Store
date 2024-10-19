import QtQuick 6.6

import "../Custom"

Rectangle {
  id: sizesDelegate

  required property int sizeId
  required property string sizeName

  required property int index

  property alias myMouseArea: mouseArea

  implicitHeight: 30
  implicitWidth: sizeTableView.width

  clip: true

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
  }

  color: mouseArea.pressed ? Qt.lighter(
                               Style.generalButtonColor,
                               1.3) : mouseArea.containsMouse ? Qt.lighter(
                                                                  Style.generalButtonColor,
                                                                  1.2) : Style.generalButtonColor
  border.color: Style.borderColor

  Text {
    text: sizeName
    color: Style.textColor
    font.pointSize: 14
    anchors.centerIn: parent
  }
}
