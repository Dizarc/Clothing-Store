import QtQuick 6.6
import QtQuick.Controls.Basic

import com.company.SizesModel
import com.company.ClothesSizesModel

import "../../Custom"

Window {
  id: addSizeWindow

  property int cId: -1

  title: "Add a new size to clothing item"

  flags: Qt.Dialog

  color: Style.backgroundColor

  height: 400
  width: 200

  onActiveChanged: {
    if (!addSizeWindow.active)
      addSizeWindow.close();
    SizesModel.filterAvailableSizes(clothingItem.clothingId);
  }

  TableView{
    id: sizeTableView

    anchors.fill: parent

    flickableDirection: Flickable.VerticalFlick
    boundsBehavior: Flickable.StopAtBounds

    selectionModel: ItemSelectionModel{
      id: sizeSelectionModel
    }

    model: SizesModel

    delegate: ItemDelegate{
      id: sizesDelegateItem

      required property int sizeId
      required property string sizeName

      required property bool selected
      required property int index

      implicitWidth: sizeTableView.width
      implicitHeight: 30

      onClicked: {
        sizeSelectionModel.select(sizeTableView.index(sizesDelegateItem.index, 0), ItemSelectionModel.SelectCurrent)
        if(ClothesSizesModel.addSize(cId, sizesDelegateItem.sizeId)){
          clothingItem.textState = "successCreated"
          addSizeWindow.close();
        }
        else{
          clothingItem.textState = "failedCreated"
          addSizeWindow.close();
        }
      }

      background: Rectangle{
        color: selected ? Qt.lighter(Style.generalButtonColor, 1.3) : sizesDelegateItem.hovered ? Qt.lighter(Style.generalButtonColor, 1.2) : Style.generalButtonColor
        border.color: Style.borderColor
        radius: 1
      }

      contentItem: Row{
        spacing: 5
        Text{
          text: sizeId
          color: Style.textColor
          font.pointSize: 12
          anchors.verticalCenter: parent.verticalCenter
        }
        Text{
          text: sizeName
          color: Style.textColor
          font.pointSize: 12
          anchors.verticalCenter: parent.verticalCenter
        }
      }

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.NoButton

      }
    }
  }
}
