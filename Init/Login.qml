import QtQuick 6.6
import QtQuick.Layouts
import QtQuick.Controls.Basic
import QtQuick.Dialogs

import "../Custom"

Item{
  id: loginItem

  property alias username: usernameInput.text
  property alias password: passwordInput.text

  property alias wrongLoginText: loginError.visible

  GridLayout{
    id: grid

    anchors.centerIn: parent

    rows: 4
    columns: 2

    rowSpacing: 10
    columnSpacing: 10

    Image{
      source: "../images/logo.png"

      Layout.columnSpan: 2
      Layout.bottomMargin: 50

      sourceSize.width: 400
      sourceSize.height: 400
    }

    Text{
      text: qsTr("Username:")

      color: Style.textColor
      font.pointSize: 12
    }

    Rectangle{
      width: 300
      height: 25

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1
      radius: 8

      TextInput{
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

    Text{
      text: qsTr("Password:")

      color: Style.textColor
      font.pointSize: 12
    }

    Rectangle{
      width: 300
      height: 25

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1
      radius: 8

      TextInput{
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

    CustomButton{
      id: loginButton

      text: qsTr("Login")

      buttonColor: Style.acceptButtonColor

      Keys.onReturnPressed: clicked()
      onClicked: db.loginCheck(username, password)
    }

    CustomButton{
      id: exitButton

      text: qsTr("Exit")

      buttonColor: Style.denyButtonColor

      onClicked: Qt.quit()
    }
  }

  Text{
    id: loginError

    anchors.top: grid.bottom
    anchors.left: grid.left

    text: qsTr("Wrong username or password try again...")

    color: "#B21B00"
    font.bold: true
    visible: false
  }


}
