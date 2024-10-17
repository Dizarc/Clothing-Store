import QtQuick 6.6
import QtQuick.Controls.Basic
import QtQuick.Layouts

import "../Custom"

import com.company.SizesModel

Window {
  id: sizeAddWindow

  title: qsTr("Sizes")

  flags: Qt.Dialog

  color: Style.backgroundColor

  height: 500
  width: 400

  onActiveChanged: {
    if (!sizeAddWindow.active)
      sizeAddWindow.close()
  }

  InfoDialog {
    id: sizeInfoDialog
  }

  ColumnLayout {
    anchors.fill: parent
    spacing: 5

    Text {
      text: qsTr("Enter a new size name:")
      font.pointSize: 12
      color: Style.textColor
    }

    CustomInputBox {
      id: sizeNameInputBox
      font.pointSize: 12
      focus: true
    }

    CustomButton {
      text: qsTr("Add")

      buttonColor: Style.acceptButtonColor

      onClicked: {
        if (SizesModel.addSize(sizeNameInputBox.text))
          sizeInfoDialog.dialogText = qsTr("Successfully added size!")
        else
          sizeInfoDialog.dialogText = qsTr("Error while adding size!")

        sizeInfoDialog.show()
      }
    }

    Text {
      text: qsTr("Click a size to delete it:")
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

          enabled: isAdminLogged
          opacity: isAdminLogged ? 1 : 0.5

          myMouseArea.onClicked: { 
            deleteSizeDialog.id = sizesDel.sizeId
            deleteSizeDialog.show()
          }
        }
      }
    }
  }

  ConfirmDialog {
    id: deleteSizeDialog

    property int id: -1

    dialogText: qsTr(
          "Are you sure you want to delete this size?\nAll clothing items with this size will be removed.")

    onClickedYes: {
      if (SizesModel.removeSize(deleteSizeDialog.id))
        sizeInfoDialog.dialogText = qsTr("Successfully deleted size!")
      else
        sizeInfoDialog.dialogText = qsTr("Error while deleting size!")

      sizeInfoDialog.show()
      deleteSizeDialog.close()
    }
  }
}
