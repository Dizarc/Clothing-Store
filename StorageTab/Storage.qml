import QtQuick 6.6
import QtQuick.Controls
import QtQuick.Layouts

import "../../ClothingStore"

import "../StorageTab/ClothesTypes"
import "../StorageTab/Clothes"

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
        if(storageView.currentItem !== storageView.initialItem ){
          storageView.pop()
          enabled = false
        }
      }
    }

    StackView {
      id: storageView

      initialItem: clothesTypesComponent

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

        onRunningChanged:{
          if(running === false)
            if(storageView.currentItem === clothesTypesComponent)
              clothes.clothesTypeId = -1;
        }
      }
    }
    Component{
      id: clothesTypesComponent
      ClothesTypes{
      }
    }

    Component{
      id: clothesComponent
      Clothes{
        id: clothes
      }
    }
  }
}
