import QtQuick 6.6

import "../../../ClothingStore"

Rectangle {
  id: clothesDelegate

  color: Qt.darker(Style.backgroundColor, 1.5)
  implicitWidth: 100
  implicitHeight: 50
  required property string clothingId
  required property string clothingName
  required property string typeId

  required property int index

  Row{
    spacing: 5

    Text{
      text: clothingId
      color: Style.textColor
    }

    Text{
      text: clothingName
      color: Style.textColor
    }
    Text{
      text: typeId
      color: Style.textColor
    }
  }
}
