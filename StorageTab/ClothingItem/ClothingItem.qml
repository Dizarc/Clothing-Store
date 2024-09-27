import QtQuick 6.6
import QtQuick.Controls.Basic
import QtQuick.Layouts

import "../ClothesTypes"
import "../Clothes"
import "../"
import "../../Custom"

GridLayout {

  property string clothingId
  property string clothingName
  property string clothingDescription
  property string clothingImageSource

  rows: 3
  columns: 2

  // StorageTabInfoText{
  //   id: clothesOutputText
  // }

  Image {
    id: imageView

    source: clothingImageSource !== "" ? "file:/" + clothingImageSource : ""
    visible: clothingImageSource !== ""

    Layout.column: 0
    Layout.rowSpan: 3
    Layout.fillHeight: true
    Layout.preferredWidth: parent.width / 4

    fillMode: Image.PreserveAspectFit
  }

  Text {
    text: clothingName
    font.pointSize: 15
    color: Style.textColor

    Layout.alignment: Qt.AlignHCenter
  }

  ScrollView{
    id: scrollView

    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    ScrollBar.vertical.policy: ScrollBar.AlwaysOn

    Layout.preferredWidth: parent.width / 4
    Layout.fillHeight: true

    TextArea{
      readOnly: !isAdminLogged

      text: clothingDescription
      font.pointSize: 12
      color: Style.textColor

      background: Rectangle{

        color: Style.inputBoxColor
        border.color: Style.borderColor
      }
    }
  }

}
