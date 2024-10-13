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
          infoDialog.dialogText = qsTr("Successfully added size!")
        else
          infoDialog.dialogText = qsTr("Error while adding size!")

        infoDialog.show()
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
            deleteDialog.id = sizesDel.sizeId
            deleteDialog.show()

          }
        }
      }
    }
  }

  Window {
    id: infoDialog

    property alias dialogText: infoDialogText.text

    title: qsTr("Information")
    width: 200
    height: 150
    color: Style.backgroundColor
    flags: Qt.Dialog
    modality: Qt.WindowModal

    Text {
      id: infoDialogText

      anchors.centerIn: parent
      text: ""

      color: Style.textColor
      font.pointSize: 12
    }

    CustomButton{
      text: qsTr("Ok")
      width: 50

      buttonColor: Style.generalButtonColor

      anchors{
        top: infoDialogText.bottom
        topMargin: 5

        right: parent.right
        rightMargin: 5
      }

      onClicked: {
          infoDialog.close()
      }
    }
  }

  Window {
    id: deleteDialog

    property int id: -1
    property alias dialogText: deleteDialogText.text

    title: qsTr("Delete information")
    width: 350
    height: 150
    color: Style.backgroundColor
    flags: Qt.Dialog
    modality: Qt.WindowModal

    Text {
      id: deleteDialogText

      wrapMode: Text.WordWrap
      anchors.centerIn: parent
      text: qsTr("Are you sure you want to delete this size?\nAll clothing items with this size will be removed.")

      color: Style.textColor
      font.pointSize: 12
    }

    Row{
      spacing: 4

      anchors{
        top: deleteDialogText.bottom
        topMargin: 5

        right: parent.right
        rightMargin: 5
      }

      CustomButton{
        text: qsTr("Yes")
        width: 50

        buttonColor: Style.generalButtonColor

        onClicked: {
          if (SizesModel.removeSize(deleteDialog.id))
            infoDialog.dialogText = qsTr("Successfully deleted size!")
           else
            infoDialog.dialogText = qsTr("Error while deleting size!")

          infoDialog.show()

          deleteDialog.close()
        }

      }

      CustomButton{
        text: qsTr("No")
        width: 50

        buttonColor: Style.generalButtonColor

        onClicked: deleteDialog.close()

      }
    }
  }
}
