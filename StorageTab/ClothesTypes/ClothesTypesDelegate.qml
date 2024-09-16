import QtQuick 6.6
import QtQuick.Controls

import "../../../ClothingStore"
import "../../Custom"

Rectangle {
  id: clothesTypesDelegate

  required property string typeId
  required property string typeName
  required property string typeImageSource

  required property int index

  width: clothesTypesView.cellWidth - 5
  height: clothesTypesView.cellHeight - 5

  color: typeMouseArea.pressed ? Qt.lighter(
                                   Style.inputBoxColor,
                                   1.5) : (typeMouseArea.hovered ? Qt.lighter(
                                                                     Style.inputBoxColor,
                                                                     1.2) : Style.inputBoxColor)
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
                   clothesTypesColumn.clothesTypesTextState = ""

                   backButton.enabled = true

                   storageView.push(clothesComponent, {
                                      "clothesTypeId": typeId
                                    })
                  } else if (mouse.button === Qt.RightButton)
                    contextMenu.popup()
                }
  }

  Column {
    id: delegateColumn
    anchors.fill: parent
    spacing: 10

    Text {
      id: textView

      text: typeName
      height: implicitHeight
      width: parent.width - 6

      anchors.horizontalCenter: parent.horizontalCenter
      horizontalAlignment: Text.AlignHCenter
      wrapMode: Text.Wrap

      font.pointSize: 12
      color: Style.textColor
    }

    Image {
      id: imageView

      anchors.horizontalCenter: parent.horizontalCenter
      source: typeImageSource !== "" ? "file:/" + typeImageSource : ""
      visible: typeImageSource !== ""

      width: clothesTypesDelegate.width - 6
      height: Math.min((clothesTypesDelegate.height - textView.height - delegateColumn.spacing), clothesTypesDelegate.height - 6)

      fillMode: Image.PreserveAspectFit
    }
  }

  Menu {
    id: contextMenu

    Action {
      text: qsTr("Delete")

      onTriggered: {
        deleteClothesTypesDialog.id = typeId
        deleteClothesTypesDialog.open()
      }
    }

    Action {
      text: qsTr("Rename")

      onTriggered: {
        renameClothesTypesDialog.id = typeId
        renameClothesTypesDialog.open()
      }
    }

    Action {
      text: qsTr("Change Image")

      onTriggered: {
        changeImageClothesTypesDialog.id = typeId
        changeImageClothesTypesDialog.open()
      }
    }

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
                implicitHeight: 40
                color: menuItem.highlighted ? Style.inputBoxColor : Style.backgroundColor
            }
        }

        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 40
            color: Style.backgroundColor
            border.color: Style.borderColor
            radius: 2
        }
  }
}
