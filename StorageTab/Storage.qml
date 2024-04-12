import QtQuick 6.6
import QtQuick.Controls

import "../../ClothingStore"

import com.company.ClothesTypesModel

Item {
  id: storageItem

  anchors.fill: parent

   SwipeView{
     currentIndex: 0
     interactive: false
     anchors.fill: parent

     Item{
      GridView{
        id: clothesTypesGrid

        cellWidth: 150
        cellHeight: 200
        anchors.fill: parent

        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        highlight: Rectangle{
          color: "lightsteelblue"; radius: 5
          width: clothesTypesGrid.cellWidth
          height: clothesTypesGrid.cellHeight
          //highlight does not work.
        }
        focus: true

        model: ClothesTypesModel

        delegate: ClothesTypesDelegate {}
      }
    }
     Item{
       //SECOND PAGE - WHEN STYLE IS CLICKED SEND THE STYLE AND SHOW A NEW VIEW.
     }
  }
}
