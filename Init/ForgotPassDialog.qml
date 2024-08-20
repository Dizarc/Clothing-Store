import QtQuick 6.6
import QtQuick.Layouts
import QtQuick.Controls.Basic
import QtQuick.Dialogs

import "../Custom"
import com.company.DatabaseController

Dialog{
    id: forgotPassDialogItem

    property int visibilityStage: 0

    implicitWidth: 350
    implicitHeight: 500
    anchors.centerIn: Overlay.overlay

    title: qsTr("Forgot Password");

    modal: true

    footer: DialogButtonBox{
      delegate: CustomButton{
        buttonColor: Style.generalButtonColor
      }
      standardButtons: Dialog.Cancel
    }

    background: Rectangle{
      color: Qt.darker(Style.backgroundColor, 1.5)
      border.color: Style.borderColor
    }

    onRejected: {
      forgotPassDialog.close();
      forgotPassDialog.visibilityStage = 0;
    }

    Connections{
      target: dbController

      function onRightPassResetCode(){
        forgotPassDialog.visibilityStage = 2;
      }
    }

    Column {
      anchors.fill: parent

      spacing: 10

      Text {
        text: qsTr("Enter username:")

        color: Style.textColor
        font.pointSize: 12
      }

      Rectangle {
        width: 200
        height: 25

        color: Style.inputBoxColor
        border.color: Style.borderColor
        border.width: 1
        radius: 8

        TextInput {
          id: forgotPassUsername

          anchors.fill: parent

          leftPadding: 8

          activeFocusOnTab: true
          focus: true

          cursorVisible: true

          color: Style.textColor
          font.pointSize: 12
          maximumLength: 25
        }
      }

      CustomButton {
        text: qsTr("Send Email")

        buttonColor: Style.generalButtonColor

        onClicked: {
          forgotPassDialog.visibilityStage = 1;
        }
      }

      Text {
        id: forgotPassCodeText

        visible: forgotPassDialog.visibilityStage > 0 ? true : false
        text: qsTr("Enter the code we sent to the email:")

        color: Style.textColor
        font.pointSize: 12
      }

      Rectangle {
        id: forgotPassCodeInputRect

        visible: forgotPassDialog.visibilityStage > 0 ? true : false

        width: 200
        height: 25

        color: Style.inputBoxColor
        border.color: Style.borderColor
        border.width: 1
        radius: 8

        TextInput {
          id: forgotPassCodeInput

          anchors.fill: parent

          leftPadding: 8

          activeFocusOnTab: true
          focus: true

          cursorVisible: true

          color: Style.textColor
          font.pointSize: 12
          maximumLength: 25
        }
      }

      CustomButton {
        id: checkCodeButton

        text: qsTr("Check Code")

        visible: forgotPassDialog.visibilityStage > 0 ? true : false

        buttonColor: Style.generalButtonColor

        onClicked: {
          dbController.forgotPassword(forgotPassCodeInput.text);
        }
      }

      Text {
        id: enterNewPassText

        visible: forgotPassDialog.visibilityStage > 1 ? true : false
        text: qsTr("Enter new password:")

        color: Style.textColor
        font.pointSize: 12
      }

      Rectangle {
        id: enterNewPassInputRect

        visible: forgotPassDialog.visibilityStage > 1 ? true : false

        width: 200
        height: 25

        color: Style.inputBoxColor
        border.color: Style.borderColor
        border.width: 1
        radius: 8

        TextInput {
          id: enterNewPassInput

          anchors.fill: parent

          leftPadding: 8

          activeFocusOnTab: true
          focus: true

          cursorVisible: true

          color: Style.textColor
          font.pointSize: 12
          maximumLength: 25
        }
      }
      Text {
        id: reenterNewPassText

        visible: forgotPassDialog.visibilityStage > 1 ? true : false
        text: qsTr("Re-enter new password:")

        color: Style.textColor
        font.pointSize: 12
      }

      Rectangle {
        id: reenterNewPassInputRect

        visible: forgotPassDialog.visibilityStage > 1 ? true : false

        width: 200
        height: 25

        color: Style.inputBoxColor
        border.color: Style.borderColor
        border.width: 1
        radius: 8

        TextInput {
          id: reenterNewPassInput

          anchors.fill: parent

          leftPadding: 8

          activeFocusOnTab: true
          focus: true

          cursorVisible: true

          color: Style.textColor
          font.pointSize: 12
          maximumLength: 25
        }
      }

      CustomButton {
        id: changePassButton

        text: qsTr("Change password")

        visible: forgotPassDialog.visibilityStage > 1 ? true : false

        buttonColor: Style.generalButtonColor

        onClicked: {
          //dbController.forgotPassword(forgotPassCodeInput.text);
        }
      }
    }
  }
