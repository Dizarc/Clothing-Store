import QtQuick 6.6

import "../../../ClothingStore"
import "../../Custom"

Rectangle {
  id: clothesDelegate

  required property string clothingId
  required property string clothingName
  required property string clothingDescription
  required property string clothingImageSource
  required property string typeId

  required property int index

  width: clothesGridView.cellHeight - 5
  height: clothesGridView.cellHeight - 5

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

    onClicked: {
      clothesGridView.currentIndex = index
      clothesColumn.clothesTextState = ""

      storageView.push(clothingComponent, {
                         "clothingId": clothingId
                       })
    }
  }

  Column {
    id: delegateColumn

    anchors.fill: parent
    spacing: 10

    Text {
      id: textView
      text: clothingName

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
      source: clothingImageSource !== "" ? "file:/" + clothingImageSource : ""
      visible: clothingImageSource !== ""

      width: clothesDelegate.width - 6
      height: Math.min(
                (clothesDelegate.height - textView.height - delegateColumn.spacing),
                clothesDelegate.height - 6)

      fillMode: Image.PreserveAspectFit
    }
  }
}
