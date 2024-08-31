import QtQuick 6.6
import QtQuick.Layouts

import "../Custom"

import com.company.ClothesTypesModel

ColumnLayout {
  id: clothesTypesColumn

  spacing: 10

  CustomButton {
    id: addTypesButton

    enabled: isAdminLogged

    text: qsTr("Add a new type")
    buttonColor: Style.generalButtonColor

    onClicked: {
      var component = Qt.createComponent("ClothesTypesAdd.qml")
      var window = component.createObject()
      window.show()
    }
  }

  GridView {
    id: clothesTypesView

    Layout.fillWidth: true
    Layout.fillHeight: true

    cellWidth: 150
    cellHeight: 200

    flickableDirection: Flickable.VerticalFlick
    boundsBehavior: Flickable.StopAtBounds

    model: ClothesTypesModel

    delegate: ClothesTypesDelegate {}
  }
}
