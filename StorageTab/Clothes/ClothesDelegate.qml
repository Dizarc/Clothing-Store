import QtQuick 6.6
import QtQuick.Controls

import "../../Custom"

import com.company.ClothesSizesModel

Item {
  id: clothesDelegate

  required property int clothingId
  required property string clothingName
  required property string clothingDescription
  required property string clothingImageSource
  required property int typeId

  width: clothesGridView.cellWidth - 8
  height: clothesGridView.cellHeight - 8

  MouseArea {
    id: clothesMouseArea

    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.RightButton

    onClicked: {
      clothesColumn.clothesTextState = ""

      ClothesSizesModel.filterClothesSizes(clothingId)

      storageView.push(clothingComponent, {
                         "clothingId": clothingId,
                         "clothingName": clothingName,
                         "clothingDescription": clothingDescription,
                         "clothingImageSource": clothingImageSource,
                         "type": typeId
                       })
    }

    Rectangle {
      id: imageRect

      anchors.horizontalCenter: parent.horizontalCenter
      width: parent.width
      height: parent.height - nameText.height

      color: clothesMouseArea.pressed ? Qt.lighter(
                                          Style.inputBoxColor,
                                          1.2) : clothesMouseArea.containsMouse ? Qt.lighter(Style.inputBoxColor, 1.1) : Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 2

      Image {
        source: clothingImageSource !== "" ? "file:/" + clothingImageSource : ""
        visible: clothingImageSource !== ""
        fillMode: Image.PreserveAspectFit

        width: parent.width - 6
        anchors.centerIn: parent
      }
    }

    Text {
      id: nameText
      text: clothingName
      wrapMode: Text.Wrap
      font.pointSize: 12
      color: Style.textColor

      height: 40
      width: parent.width - 6

      anchors{
        top: imageRect.bottom
        left: imageRect.left
        leftMargin: 3
      }
    }
  }
}
