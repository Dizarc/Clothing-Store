import QtQuick 6.6
import QtQuick.Layouts
import QtQuick.Controls.Basic
import QtQuick.Dialogs

import "../Custom"

Item {
  id: loginItem

  property alias wrongLogin: wrongLoginText.visible

  GridLayout {
    anchors.centerIn: parent

    rows: 6
    columns: 2

    rowSpacing: 10
    columnSpacing: 10

    Image {
      source: "../images/logo.png"

      Layout.columnSpan: 2
      Layout.bottomMargin: 50

      sourceSize.width: 400
      sourceSize.height: 400
    }

    Text {
      text: qsTr("Username:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: usernameInput
    }

    Text {
      text: qsTr("Password:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: passwordInput
      echo: TextInput.Password
    }

    CustomButton {
      text: qsTr("Login")

      buttonColor: Style.acceptButtonColor

      Keys.onReturnPressed: clicked()
      onClicked: dbController.loginCheck(usernameInput.text, passwordInput.text)
    }

    CustomButton {
      text: qsTr("Exit")

      buttonColor: Style.denyButtonColor

      onClicked: Qt.quit()
    }

    CustomButton {
      text: qsTr("Forgot password")

      buttonColor: Style.generalButtonColor

      onClicked: {
        var d = forgotPassDialogComponent.createObject(loginItem);
        d.show();
      }
    }

    Text {
      id: wrongLoginText

      visible: false

      text: qsTr("Wrong credentials try again...")
      font.bold: true
      color: Style.denyButtonColor
    }
  }

  Component{
    id: forgotPassDialogComponent
    ForgotPassDialog {
      id: forgotPassDialog
    }
  }
}
