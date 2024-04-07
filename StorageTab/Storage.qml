import QtQuick 6.6
import QtQuick.Controls

import "../../ClothingStore"

import com.company.Clothing

Item {
  id: storageItem

  anchors.fill: parent

  TreeView{
    id: treeView
    anchors.fill: parent

    model: Clothing

    delegate: StorageDelegate {
      color: selected ? Qt.lighter(Style.backgroundColor, 2) : Style.backgroundColor
      required property bool selected
    }


  }
}
