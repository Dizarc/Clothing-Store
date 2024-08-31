import QtQuick 6.6
import QtQuick.Controls

import "../Custom"

Dialog {
  id: clothesTypesEditingDialog

  property int id: -1

  anchors.centerIn: Overlay.overlay

  modal: true

  footer: DialogButtonBox {

    delegate: CustomButton {
      buttonColor: Style.generalButtonColor
    }

    standardButtons: Dialog.Yes | Dialog.Cancel
  }

  background: Rectangle {
    color: Qt.darker(Style.backgroundColor, 1.5)
    border.color: Style.borderColor
  }

  onRejected: clothesTypesEditingDialog.close()
}
