import QtQuick 6.6
import QtQuick.Controls

import "../../ClothingStore"

import com.company.ClothesTypesModel
import com.company.ClothesModel

Item {
  id: storageItem

  anchors.fill: parent

  CustomButton{
    id: backButton

    enabled: false

    anchors.top: parent.top
    anchors.left: parent.left

    text: qsTr("BACK")
    buttonColor: Qt.lighter(Style.backgroundColor, 1.5)

    onClicked: {
      storageView.pop();
      enabled = false;
    }
  }

  StackView{
    id: storageView

    anchors.top: backButton.bottom
    anchors.topMargin: 5
    width: parent.width
    height: parent.height - backButton.height

    initialItem: clothesTypesView
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

  TreeView{
    id: clothesView

    model: ClothesModel

    delegate: ClothesDelegate {}
  }
}
