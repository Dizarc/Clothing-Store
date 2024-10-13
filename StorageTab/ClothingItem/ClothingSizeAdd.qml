import QtQuick 6.6
import QtQuick.Controls.Basic
import QtQuick.Layouts

import com.company.SizesModel
import com.company.ClothesSizesModel

import "../../Custom"
import "../"

Window {
  id: addSizeWindow

  property int cId: -1

  title: "Add a new size to clothing item"

  flags: Qt.Dialog

  color: Style.backgroundColor

  height: 300
  width: 200

  onActiveChanged: {
    if (!addSizeWindow.active)
      addSizeWindow.close()
  }

  ColumnLayout {
    anchors.fill: parent
    spacing: 5

    Text {
      text: qsTr("Available sizes:")
      font.pointSize: 12
      color: Style.textColor
    }

    ScrollView {
      Layout.fillWidth: true
      Layout.fillHeight: true

      ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
      ScrollBar.vertical.policy: ScrollBar.AlwaysOn

      TableView {
        id: sizeTableView

        width: parent.width

        clip: true
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        model: SizesModel

        delegate: SizesDelegate {
          id: sizesDel

          width: sizeTableView.width

          myMouseArea.onClicked: {
            if (ClothesSizesModel.addSize(cId, sizesDel.sizeId)) {
              clothingItem.textState = "successCreated"
              addSizeWindow.close()
            } else {
              clothingItem.textState = "failedCreated"
              addSizeWindow.close()
            }
          }
        }
      }
    }
  }
}
