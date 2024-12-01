import QtQuick 6.8
import QtQuick.Layouts
import QtQuick.Controls.Basic
import QtQuick.Dialogs

import com.company.DatabaseController

import "../Custom"

Item {
  id: loginItem

  property alias wrongLogin: wrongLoginText.visible

  ColumnLayout {
    spacing: 15

    anchors.verticalCenterOffset: -80
    anchors.centerIn: parent

    Image {
      source: "../images/logo.png"

      Layout.alignment: Qt.AlignHCenter

      fillMode: Image.PreserveAspectFit
      sourceSize.width: Window.width / 3.5
    }

    Row {
      spacing: 10
      Layout.alignment: Qt.AlignHCenter

      Text {
        text: qsTr("Username:")

        color: Style.textColor
        font.pointSize: 12
      }

      CustomInputBox {
        id: usernameInput
      }
    }

    Row {
      spacing: 10
      Layout.alignment: Qt.AlignHCenter

      Text {
        text: qsTr("Password: ")

        color: Style.textColor
        font.pointSize: 12
      }

      CustomInputBox {
        id: passwordInput
        echo: TextInput.Password
        Keys.onReturnPressed: loginButton.clicked()
      }
    }

    Row {
      spacing: 10
      Layout.alignment: Qt.AlignHCenter

      CustomButton {
        id: loginButton

        text: qsTr("Login")

        buttonColor: Style.acceptButtonColor

        focus: true
        Keys.onReturnPressed: clicked()

        onClicked: DbController.loginCheck(usernameInput.text,
                                           passwordInput.text)
      }

      CustomButton {
        text: qsTr("Exit")

        buttonColor: Style.denyButtonColor

        onClicked: Qt.quit()
      }
    }

    Row {
      spacing: 10
      Layout.alignment: Qt.AlignHCenter

      CustomButton {
        text: qsTr("Forgot password")

        buttonColor: Style.generalButtonColor

        onClicked: {
          var d = forgotPassDialogComponent.createObject(loginItem)
          d.show()
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
  }

  Component {
    id: forgotPassDialogComponent
    ForgotPassDialog {
      id: forgotPassDialog
    }
  }
}
