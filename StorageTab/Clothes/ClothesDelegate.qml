import QtQuick 6.6
import QtQuick.Controls

import "../../../ClothingStore"
import "../../Custom"

import com.company.ClothesSizesModel

Rectangle {
  id: clothesDelegate

  required property int clothingId
  required property string clothingName
  required property string clothingDescription
  required property string clothingImageSource
  required property int typeId

  width: clothesGridView.cellWidth - 4
  height: clothesGridView.cellHeight - 4

  color: clothesMouseArea.pressed ? Qt.lighter(
                                      Style.inputBoxColor,
                                      1.2) : clothesMouseArea.containsMouse ? Qt.lighter(Style.inputBoxColor, 1.1) : Style.inputBoxColor

  border.color: Style.borderColor
  border.width: 2

  MouseArea {
    id: clothesMouseArea

    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.RightButton

    onClicked: {
                   clothesColumn.clothesTextState = ""

                   ClothesSizesModel.filterSizes(clothingId)
                   storageView.push(clothingComponent, {
                                      "clothingId": clothingId,
                                      "clothingName": clothingName,
                                      "clothingDescription": clothingDescription,
                                      "clothingImageSource": clothingImageSource
                                    })
               }
  }

  Column {
    id: clothesDelegateColumn

    anchors.fill: parent
    spacing: 10

    Text {
      id: clothesTextView

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
      anchors.horizontalCenter: parent.horizontalCenter
      source: clothingImageSource !== "" ? "file:/" + clothingImageSource : ""
      visible: clothingImageSource !== ""

      width: clothesDelegate.width - 6
      height: Math.min(
                (clothesDelegate.height - clothesTextView.height - clothesDelegateColumn.spacing),
                clothesDelegate.height - 6)

      fillMode: Image.PreserveAspectFit
    }
  }
}
