import QtQuick 6.6
import QtQuick.Layouts
import QtQuick.Controls.Basic
import QtQuick.Dialogs

import "../Custom"

Item {
  id: loginItem

  property alias username: usernameInput.text
  property alias password: passwordInput.text

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

    Rectangle {
      width: 300
      height: 25

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1
      radius: 8

      TextInput {
        id: usernameInput

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
      text: qsTr("Password:")

      color: Style.textColor
      font.pointSize: 12
    }

    Rectangle {
      width: 300
      height: 25

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1
      radius: 8

      TextInput {
        id: passwordInput

        anchors.fill: parent

        leftPadding: 8
        echoMode: TextInput.Password

        activeFocusOnTab: true

        color: Style.textColor
        font.pointSize: 12
        maximumLength: 25
      }
    }

    CustomButton {
      text: qsTr("Login")

      buttonColor: Style.acceptButtonColor

      Keys.onReturnPressed: clicked()
      onClicked: dbController.loginCheck(username, password)
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
        d.open();
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
