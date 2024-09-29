import QtQuick 6.6
import QtQuick.Layouts
import QtQuick.Controls

import "../../Custom"
import "../"

import com.company.ClothesModel

ColumnLayout {
  id: clothesColumn

  spacing: 5

  property alias clothesTextState: clothesOutputText.state

  StorageTabInfoText{
    id: clothesOutputText
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
