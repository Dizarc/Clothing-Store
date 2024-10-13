import QtQuick 6.6
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs
import "../../Custom"
import "../"

import com.company.ClothesModel

ColumnLayout {
  id: clothesColumn

  property int type

  spacing: 5

  property alias clothesTextState: clothesOutputText.state

  StorageTabInfoText{
    id: clothesOutputText
  }

  CustomButton {
    id: addTypesButton

    enabled: isAdminLogged
    opacity: isAdminLogged ? 1 : 0.5

    text: qsTr("New item")
    buttonColor: Style.generalButtonColor

    onClicked: {
      var component = Qt.createComponent("ClothesItemAdd.qml")
      var window = component.createObject(clothesColumn, {"tId": clothesColumn.type})
      window.show()
    }
  }

  GridView {
    id: clothesGridView

    Layout.fillWidth: true
    Layout.fillHeight: true

    cellWidth: 150
    cellHeight: 200

    flickableDirection: Flickable.VerticalFlick
    boundsBehavior: Flickable.StopAtBounds

    model: ClothesModel

    delegate: ClothesDelegate { }
  }
}
