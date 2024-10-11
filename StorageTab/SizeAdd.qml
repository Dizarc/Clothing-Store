import QtQuick 6.6
import QtQuick.Controls.Basic

import "../Custom"

import com.company.SizesModel

Window {
  id: sizeAddWindow

  title: "Add a new size"

  flags: Qt.Dialog

  color: Style.backgroundColor

  height: 500
  width: 800

  onActiveChanged: {
    if (!sizeAddWindow.active)
      sizeAddWindow.close();
  }

  Column{
    anchors.fill: parent
    spacing: 5

    Text{
      text: qsTr("Size Name:")
      font.pointSize: 12
      color: Style.textColor
    }

    CustomInputBox {
      id: sizeNameInputBox
      font.pointSize: 12
      focus: true
    }

    CustomButton{
      text: qsTr("Add")

      buttonColor: Style.acceptButtonColor

      onClicked: {
        if (SizesModel.addSize(sizeNameInputBox.text)){
        }
          //popup
      }
    }

    Text{
      text: qsTr("Click to delete a size:")
      font.pointSize: 12
      color: Style.textColor
    }

    ScrollView {
      ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
      ScrollBar.vertical.policy: ScrollBar.AlwaysOn

      TableView {
        id: sizeTableView

        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds

        model: SizesModel

        delegate: SizesDelegate {
          id: sizesDel

          myMouseArea.onClicked: {
            if(SizesModel.removeSize(sizesDel.sizeId)){
              //popup with message
            }else{
              //popup with denied message
            }

          }
        }
      }
    }

  }
}
