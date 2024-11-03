import QtQuick 6.8
import QtQuick.Layouts
import QtQuick.Controls.Basic
import QtQuick.Dialogs

import "../Custom"

import com.company.DatabaseController

Window{
    id: forgotPassDialogItem

    property int visibilityStage: 0

    title: qsTr("Forgot Password")
    flags: Qt.Dialog
    modality: Qt.WindowModal
    color: Style.backgroundColor

    width: 350
    height: 600

    Connections{
      target: DbController

      function onRightPassResetCode(){
        checkCodeText.text = qsTr("Code is correct. Enter new password");
        checkCodeText.color =  Style.acceptButtonColor

        forgotPassDialog.visibilityStage = 2;
      }

      function onWrongCode(){
        checkCodeText.text = qsTr("Code expired or wrong code!")
        checkCodeText.color =  Style.denyButtonColor
      }

      function onSuccessChangePass(){
        passwordChangeInfo.text = qsTr("Password changed Successfully!");
        passwordChangeInfo.color =  Style.acceptButtonColor
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

      CustomInputBox{
        id: forgotPassUsernameInput
      }

      CustomButton {
        id: sendEmailButton

        text: qsTr("Send Email")

        buttonColor: Style.generalButtonColor

        onClicked: {
          DbController.sendResetEmail(forgotPassUsernameInput.text);
          forgotPassDialog.visibilityStage = 1;

          sendEmailButton.enabled = false;
        }
      }

      Text {
        id: forgotPassCodeText

        visible: forgotPassDialog.visibilityStage > 0 ? true : false
        text: qsTr("Enter the code we sent to the email:")

        color: Style.textColor
        font.pointSize: 12
      }

      CustomInputBox{
        id: forgotPassCodeInput
        visible: forgotPassDialog.visibilityStage > 0 ? true : false
      }


      CustomButton {
        id: checkCodeButton

        text: qsTr("Check Code")

        visible: forgotPassDialog.visibilityStage > 0 ? true : false

        buttonColor: Style.generalButtonColor

        onClicked: {
          DbController.checkResetCode(forgotPassUsernameInput.text ,forgotPassCodeInput.text);
        }
      }

      Text {
        id: checkCodeText

        text: qsTr("")
        font.bold: true
        font.pointSize: 12
      }

      Text {
        id: enterNewPassText

        visible: forgotPassDialog.visibilityStage > 1 ? true : false
        text: qsTr("Enter new password:")

        color: Style.textColor
        font.pointSize: 12
      }

      CustomInputBox{
        id: enterNewPassInput
        echo: TextInput.Password
        visible: forgotPassDialog.visibilityStage > 1 ? true : false
      }

      Text {
        id: reenterNewPassText

        visible: forgotPassDialog.visibilityStage > 1 ? true : false
        text: qsTr("Re-enter new password:")

        color: Style.textColor
        font.pointSize: 12
      }

      CustomInputBox{
        id: reenterNewPassInput
        echo: TextInput.Password
        visible: forgotPassDialog.visibilityStage > 1 ? true : false
      }

      CustomButton {
        id: changePassButton

        text: qsTr("Change password")

        visible: forgotPassDialog.visibilityStage > 1 ? true : false

        buttonColor: Style.generalButtonColor

        onClicked: {
          if(enterNewPassInput.text == reenterNewPassInput.text){
            DbController.changePassword(forgotPassUsernameInput.text, enterNewPassInput.text);

          }else {
            passwordChangeInfo.text = qsTr("Passwords do not match");
            passwordChangeInfo.color = Style.denyButtonColor
          }
        }
      }

      Text {
        id: passwordChangeInfo

        text: qsTr("")

        font.bold: true
        font.pointSize: 12
      }
    }
  }
