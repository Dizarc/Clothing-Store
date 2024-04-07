import QtQuick 6.6
import QtQuick.Controls

import "../../ClothingStore"

Rectangle{
  id: storageDelegate

  implicitWidth: treeView.width
  implicitHeight: 30

  required property string typeName

  required property int index

  Text{
    text: storageDelegate.typeName
    anchors.centerIn: parent
  }

  MouseArea{
    anchors.fill: parent
    onClicked: treeView.expand(storageDelegate.index)
  }

}
