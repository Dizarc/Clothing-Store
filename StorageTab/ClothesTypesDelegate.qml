import QtQuick 6.6
import QtQuick.Controls

import "../../ClothingStore"



Rectangle{
  id: storageDelegate

  implicitWidth: 300
  implicitHeight: 100

  required property string typeId
  required property string typeName
  required property string typeImage

  required property int index

  // MouseArea{
  //   anchors.fill: parent
  //   onClicked: treeView.expand(storageDelegate.index)
  // }

  Row{
    spacing: 5
    Text{
      text: typeId
    }

    Text{
      text: typeName
    }
    Text{
      text: typeImage
    }
  }

}
