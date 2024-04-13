import QtQuick 6.6
import QtQuick.Controls

import "../../ClothingStore"

import com.company.ClothesTypesModel
import com.company.ClothesModel

Item {
  id: storageItem

  anchors.fill: parent

  StackView{
    id: storageView

    initialItem: clothesTypesView
    anchors.fill: parent
  }

  GridView{
    id: clothesTypesView

    cellWidth: 150
    cellHeight: 200

    flickableDirection: Flickable.VerticalFlick
    boundsBehavior: Flickable.StopAtBounds

    model: ClothesTypesModel

    delegate: ClothesTypesDelegate {}
  }

  Item{
    id: clothesItem

    visible: storageView.index == 1 ? true : false

    property int id;

    Column{

      spacing: 10

      CustomButton{
        text: qsTr("BACK")
        buttonColor: Qt.lighter(Style.backgroundColor, 1.5)

        onClicked: storageView.pop()
      }

      //FOR SOME REASON THIS TABLEVIEW DOES NOT SHOW ANYTHING - FIX SOON
      TableView{
        id: clothesView

         model: ClothesModel

         delegate: ClothesDelegate {}
      }
    }
  }
}
