import QtQuick 6.6
import QtQuick.Layouts
import QtQuick.Controls.Basic
import QtQuick.Dialogs

Item{
    id: loginItem

    property alias username: usernameInput.text
    property alias password: passwordInput.text

    property alias wrongLoginText: loginError.visible


    Image{
        source: "images/logo.png"

        anchors{
            top: parent.top
            topMargin: 150
            horizontalCenter: parent.horizontalCenter
        }

        sourceSize.width: 400
        sourceSize.height: 400
    }

    GridLayout{
        id: grid

        anchors.centerIn: parent

        rows: 3
        columns: 2

        rowSpacing: 10
        columnSpacing: 10

        Text{
            text: qsTr("Username:")

            color: "#ECEDF0"
            font.pointSize: 12
        }

        Rectangle{
            width: 300
            height: 25

            color: "#3A3E44"
            border.color: "#ECEDF0"
            border.width: 1
            radius: 10

            TextInput{
                id: usernameInput

                anchors.fill: parent

                leftPadding: 5

                activeFocusOnTab: true
                focus: true

                cursorVisible: true

                color: "#ECEDF0"
                font.pointSize: 12
                maximumLength: 25

            }
        }

        Text{
            text: qsTr("Password:")

            color: "#ECEDF0"
            font.pointSize: 12

        }

        Rectangle{
            width: 300
            height: 25

            color: "#3A3E44"
            border.color: "#ECEDF0"
            border.width: 1
            radius: 10

            TextInput{
                id: passwordInput

                anchors.fill: parent

                leftPadding: 5
                echoMode: TextInput.Password

                activeFocusOnTab: true

                color: "#ECEDF0"
                font.pointSize: 12
                maximumLength: 25
            }
        }

        CustomButton{
            id: loginButton

            text: qsTr("Login")

            buttonColor: "#399F2E"

            Keys.onReturnPressed: clicked()
            onClicked: db.loginCheck(username, password)
        }

        CustomButton{
            id: exitButton

            text: qsTr("Exit")

            buttonColor: "#6C261F"

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
