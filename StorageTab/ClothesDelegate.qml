import QtQuick 6.6

import "../../ClothingStore"

Rectangle {
  id: clothesDelegate

  implicitWidth: 500
  implicitHeight: 500
  required property string clothingId
  required property string clothingName
  required property string typeId

  required property int index

  Row{
    anchors.centerIn: parent
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
