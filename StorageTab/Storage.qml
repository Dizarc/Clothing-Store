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
    rows: 3

    columnSpacing: 10
    rowSpacing: 10

    CustomButton {
      id: backButton

      enabled: false

      text: qsTr("BACK")
      buttonColor: Style.generalButtonColor

      onClicked: {
        storageView.pop()
        enabled = false
      }
    }

    CustomButton {
      id: addTypesButton

      enabled: isAdminLogged

      Layout.row: 1
      Layout.column: 0

      text: qsTr("Add a new type")
      buttonColor: Style.generalButtonColor

      onClicked: {
        var component = Qt.createComponent("ClothesTypesAdd.qml")
        var window = component.createObject()
        window.show()
      }
    }

    StackView {
      id: storageView

      initialItem: clothesTypesView

      width: parent.width
      height: parent.height

      Layout.row: 2
      Layout.column: 0
      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.topMargin: 20

      pushEnter: Transition {
        YAnimator {
          from: (storageView.mirrored ? -1 : 1) * storageView.height
          to: 0
          duration: 400
          easing.type: Easing.OutCubic
        }
      }

      popExit: Transition {
        YAnimator {
          from: 0
          to: (storageView.mirrored ? -1 : 1) * storageView.height
          duration: 400
          easing.type: Easing.OutCubic
        }
      }
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
