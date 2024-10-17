import QtQuick 6.6
import QtQuick.Controls
import QtQuick.Layouts

import "../Custom"
import "../../ClothingStore"

import "../StorageTab/ClothesTypes"
import "../StorageTab/Clothes"
import "../StorageTab/ClothingItem"

import com.company.SizesModel

Column {
  id: storageItem

  anchors.fill: parent
  spacing: 5

  Row{
    spacing: 5

    CustomButton {
      text: qsTr("< Back")
      buttonColor: Style.generalButtonColor

      onClicked: {
        if (storageView.currentItem !== storageView.initialItem)
          storageView.pop()
      }
    }

    CustomButton{
      text: qsTr("Sizes")

      buttonColor: Style.generalButtonColor

      onClicked: {
        SizesModel.filterAvailableSizes();

        var component = Qt.createComponent("Sizes.qml")
        var window = component.createObject()
        window.show()
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
    Layout.topMargin: 10

    pushEnter: Transition {
      YAnimator {
        from: (storageView.mirrored ? -1 : 1) * storageView.height
        to: 0
        duration: 300
        easing.type: Easing.OutCubic
      }
    }

    popExit: Transition {
      YAnimator {
        from: 0
        to: (storageView.mirrored ? -1 : 1) * storageView.height
        duration: 300
        easing.type: Easing.OutCubic
      }
    }

    InfoDialog {
      id: infoDialog
    }
  }

  Component {
    id: clothesTypesComponent
    ClothesTypes { }
  }

  Component {
    id: clothesComponent
    Clothes { }
  }

  Component {
    id: clothingComponent
    ClothingItem { }
  }
}
