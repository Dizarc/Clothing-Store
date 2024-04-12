import QtQuick 6.6
import QtQuick.Controls

import "../../ClothingStore"

Rectangle{
  id: storageDelegate

  required property string typeId
  required property string typeName
  required property string typeImage

  required property int index

  width: clothesTypesGrid.cellWidth - 5
  height: clothesTypesGrid.cellHeight - 5
  //color: Qt.darker(Style.backgroundColor, 1.5)
  border.color: "black"
  border.width: 2

  MouseArea{
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    onEntered: {
      console.log(index)


    }
    onClicked: {
      clothesTypesGrid.currentIndex = index;
    }

  }

  Column{
    anchors.centerIn: parent
    spacing: 5
    Text{
      text: typeId
      color: Style.textColor
    }

    Text{
      text: typeName
      color: Style.textColor
    }
    Text{
      text: typeImage
      color: Style.textColor
    }
  }
}
