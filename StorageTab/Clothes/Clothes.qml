import QtQuick 6.8
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs

import "../../Custom"
import "../"

import com.company.ClothesModel

ColumnLayout {
  id: clothesColumn

  property int type
  property alias clothesTextState: clothesOutputText.state

  spacing: 5

  StorageTabInfoText{
    id: clothesOutputText
  }

  InfoDialog {
    id: clothesInfoDialog
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

    cellWidth: 200
    cellHeight: 300

    clip: true
    flickableDirection: Flickable.VerticalFlick
    boundsBehavior: Flickable.StopAtBounds
    ScrollIndicator.vertical: ScrollIndicator {
      id: myScroll
      contentItem: Rectangle {
        implicitWidth: 2
        radius: 5
        color: myScroll.active ? Style.textColor : "transparent"
      }
    }

    model: ClothesModel

    delegate: ClothesDelegate { }
  }
}
