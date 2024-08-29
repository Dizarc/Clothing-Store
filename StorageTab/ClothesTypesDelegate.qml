import QtQuick 6.6
import QtQuick.Controls

import "../../ClothingStore"

Rectangle{
  id: clothesTypesDelegate

  required property string typeId
  required property string typeName
  required property string typeImageSource

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

      backButton.enabled = true;

      storageView.push(clothesView, {"clothesTypeId" : typeId});
    }
  }

  Column{
    anchors.centerIn: parent
    spacing: 5

    Text{
      text: typeName
      color: Style.textColor
    }

    Image {
      id: imageView

      source: "file:/" + typeImageSource

      sourceSize.width: 50
      sourceSize.height: 70

    }
  }
}
