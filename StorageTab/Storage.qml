import QtQuick 6.6
import QtQuick.Controls
import QtQuick.Layouts

import "../../ClothingStore"

import com.company.ClothesTypesModel
import com.company.ClothesModel

Item {
  id: storageItem

  anchors.fill: parent

  GridLayout {
    id: storageGrid

    anchors.fill: parent
    columns: 2
    rows: 2

    columnSpacing: 10
    rowSpacing: 10

    CustomButton {
      id: backButton

      enabled: false

      text: qsTr("BACK")
      buttonColor: Style.generalButtonColor

      onClicked: {
        storageView.pop();
          enabled = false
      }
    }

    CustomButton {
      id: addTypesButton

      text: qsTr("Add a new type")
      buttonColor: Style.generalButtonColor

      onClicked: {

      }
    }

    StackView {
      id: storageView

      width: parent.width / 2

      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.maximumWidth: parent.width / 2
      Layout.topMargin: 20

      initialItem: clothesTypesView
    }

    GridView {
      id: clothesTypesView

      cellWidth: 150
      cellHeight: 200

      flickableDirection: Flickable.VerticalFlick
      boundsBehavior: Flickable.StopAtBounds

      model: ClothesTypesModel

      delegate: ClothesTypesDelegate {}
    }

    TreeView {
      id: clothesView

      property int clothesTypeId: -1

      model: ClothesModel

      delegate: ClothesDelegate {
        id: clothesDelegated
      }

      Component.onCompleted: {
        ClothesModel.filterTypeId = clothesTypeId
      }

      onClothesTypeIdChanged: {
        ClothesModel.filterTypeId = clothesTypeId
      }
    }
  }
}
