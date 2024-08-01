import QtQuick 6.6
import QtQuick.Controls

import "../../ClothingStore"

Rectangle{
  id: clothesTypesDelegate

  required property string typeId
  required property string typeName
  required property string typeImage

  required property int index

  width: clothesTypesView.cellWidth - 5
  height: clothesTypesView.cellHeight - 5
  color: typeMouseArea.pressed ? Qt.lighter(Style.backgroundColor, 1.5) : Qt.darker(Style.backgroundColor, 1.5)
  border.color: "black"
  border.width: 2

  MouseArea{
    id: typeMouseArea
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      clothesTypesView.currentIndex = index;
      storageView.push(clothesView/*, {"typeId" : index}*/);
      backButton.enabled = true;
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
