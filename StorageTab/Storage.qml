import QtQuick 6.6
import QtQuick.Controls

import "../../ClothingStore"

import com.company.ClothesTypesModel

Item {
  id: storageItem

  anchors.fill: parent

  // SwipeView{
  //   currentIndex: 0
  //   interactive: true

  //   Item{
      GridView{
        id: clothesTypesGrid
        anchors.fill: parent

        model: ClothesTypesModel

        delegate: ClothesTypesDelegate {}
      }
    // }
    // Item{
    //   //SECOND PAGE - WHEN STYLE IS CLICKED SEND THE STYLE AND SHOW A NEW VIEW.
    // }
  //}

  // TreeView{
  //   id: treeView
  //   anchors.fill: parent

  //   model: Clothing

  //   delegate:  StorageDelegate {
  //     //color: selected ? Qt.lighter(Style.backgroundColor, 2) : Style.backgroundColor
  //     //required property bool selected
  //   }
  // }
}
