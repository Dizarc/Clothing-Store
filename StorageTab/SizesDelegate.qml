import QtQuick 6.6

import "./ClothingItem"
import "../Custom"

Rectangle {
  id: sizesDelegate

  required property int sizeId
  required property string sizeName

  required property int index

  property alias myMouseArea: mouseArea

  implicitHeight: 30
  implicitWidth: 200

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

  Row {
    spacing: 5
    Text {
      text: sizeId
      color: Style.textColor
      font.pointSize: 12
      anchors.verticalCenter: parent.verticalCenter
    }
    Text {
      text: sizeName
      color: Style.textColor
      font.pointSize: 12
      anchors.verticalCenter: parent.verticalCenter
    }
  }
}
