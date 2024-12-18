import QtQuick 6.8
import QtQuick.Controls.Basic

import "../../Custom"

import com.company.ClothesModel

Rectangle {
  id: clothesTypesDelegate

  required property int typeId
  required property string typeName
  required property string typeImageSource

  required property int index

  width: clothesTypesView.cellWidth - 4
  height: clothesTypesView.cellHeight - 4

  color: typeMouseArea.pressed ? Qt.lighter(
                                   Style.inputBoxColor,
                                   1.2) : typeMouseArea.containsMouse ? Qt.lighter(
                                                                          Style.inputBoxColor,
                                                                          1.1) : Style.inputBoxColor
  border.color: Style.borderColor
  border.width: 2

  MouseArea {
    id: typeMouseArea

    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.RightButton

    onClicked: mouse => {
                 if (mouse.button === Qt.LeftButton) {
                   clothesTypesView.currentIndex = index

                   ClothesModel.filterType(typeId)
                   storageView.push(clothesComponent, {"type": typeId })
                 } else if (mouse.button === Qt.RightButton)
                 contextMenu.popup()
               }
  }

  Column {
    id: delegateColumn

    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 2

    Text {
      id: textView

      text: typeName

      height: implicitHeight
      width: parent.width - 6

      horizontalAlignment: Text.AlignHCenter
      wrapMode: Text.Wrap

      font.pointSize: 12
      color: Style.textColor
    }

    Image {
      id: imageView

      source: typeImageSource !== "" ? "file:/" + typeImageSource : ""
      visible: typeImageSource !== ""

      width: clothesTypesDelegate.width - 6
      height: Math.min(
                (clothesTypesDelegate.height - textView.height - delegateColumn.spacing),
                clothesTypesDelegate.height - 6)

      fillMode: Image.PreserveAspectFit
    }
  }

  Menu {
    id: contextMenu

    delegate: MenuItem {
      id: menuItem

      implicitWidth: 100
      implicitHeight: 30

      contentItem: Text {
        text: menuItem.text
        font: menuItem.font
        color: Style.textColor
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
      }

      background: Rectangle {
        implicitWidth: 100
        implicitHeight: 30
        border.color: Style.borderColor
        border.width: 1
        color: menuItem.hovered ? Qt.lighter(Style.generalButtonColor, 1.2) : Style.generalButtonColor
      }

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.NoButton
      }
    }

    background: Rectangle {
      implicitWidth: 100
      implicitHeight: 30
    }

    Action {
      text: qsTr("Delete")

      onTriggered: {
        deleteClothesTypesDialog.id = typeId
        deleteClothesTypesDialog.show()
      }
    }

    Action {
      text: qsTr("Rename")

      onTriggered: {
        renameClothesTypesDialog.id = typeId
        renameClothesTypesDialog.name = typeName
        renameClothesTypesDialog.show()
      }
    }

    Action {
      text: qsTr("Change Image")

      onTriggered: {
        changeImageClothesTypesDialog.id = typeId
        changeImageClothesTypesDialog.show()
      }
    }
  }
}
