import QtQuick 6.6
import QtQuick.Layouts
import QtQuick.Controls.Basic

import com.company.Employees

Item {
    id: employeeEditItem

    property int idField
    property alias firstnameField: firstnameEdit.text
    property alias lastnameField: lastnameEdit.text
    property alias usernameField: usernameEdit.text
    //property alias passwordField: passwordEdit.text
    property alias emailField: emailEdit.text
    property alias phoneField: phoneEdit.text

    Image {
        id: editImage

        anchors.horizontalCenter: editGrid.horizontalCenter

        source: "images/userImage.png"

        sourceSize.width: 200
        sourceSize.height: 200
    }

    Text{
        id: editText

        anchors.horizontalCenter: editGrid.horizontalCenter
        anchors.top: editImage.bottom

        text: qsTr("Edit Employee "+ usernameField);

        color: Style.textColor
        font.pointSize: 15
    }

    GridLayout{
        id: editGrid

        anchors.top: editText.bottom
        anchors.topMargin: 10

        rows: 6
        columns: 2

        rowSpacing: 10
        columnSpacing: 50

        Text{
            text: qsTr("Firstname: ");

            color: Style.textColor
            font.pointSize: 12
        }

        Rectangle{

            width: 300
            height: 25

            color: Qt.lighter(Style.backGround, 1.5)
            border.color: Style.borderColor
            border.width: 1
            radius: 5

            TextInput{
                id: firstnameEdit

                anchors.fill: parent

                leftPadding: 5

                activeFocusOnTab: true

                color: Style.textColor
                font.pointSize: 12
                maximumLength: 25

            }
        }

        Text{
            text: qsTr("Lastname: ");

            color: Style.textColor
            font.pointSize: 12
        }

        Rectangle{

            width: 300
            height: 25

            color: Qt.lighter(Style.backGround, 1.5)
            border.color: Style.borderColor
            border.width: 1
            radius: 5

            TextInput{
                id: lastnameEdit

                anchors.fill: parent

                leftPadding: 5

                activeFocusOnTab: true

                color: Style.textColor
                font.pointSize: 12
                maximumLength: 25

            }
        }

        Text{
            text: qsTr("Username: ");

            color: Style.textColor
            font.pointSize: 12
        }

        Rectangle{

            width: 300
            height: 25

            color: Qt.lighter(Style.backGround, 1.5)
            border.color: Style.borderColor
            border.width: 1
            radius: 5

            TextInput{
                id: usernameEdit

                anchors.fill: parent

                leftPadding: 5

                activeFocusOnTab: true

                color: Style.textColor
                font.pointSize: 12
                maximumLength: 25

            }
        }

        Text{
            text: qsTr("Email: ");

            color: Style.textColor
            font.pointSize: 12
        }

        Rectangle{

            width: 300
            height: 25

            color: Qt.lighter(Style.backGround, 1.5)
            border.color: Style.borderColor
            border.width: 1
            radius: 5

            TextInput{
                id: emailEdit

                anchors.fill: parent

                leftPadding: 5

                activeFocusOnTab: true

                color: Style.textColor
                font.pointSize: 12
                maximumLength: 35

            }
        }
        Text{
            text: qsTr("Phone: ");

            color: Style.textColor
            font.pointSize: 12
        }

        Rectangle{

            width: 300
            height: 25

            color: Qt.lighter(Style.backGround, 1.5)
            border.color: Style.borderColor
            border.width: 1
            radius: 5

            TextInput{
                id: phoneEdit

                anchors.fill: parent

                leftPadding: 5

                activeFocusOnTab: true

                color: Style.textColor
                font.pointSize: 12
                maximumLength: 25

            }
        }

        CustomButton{
            id: saveButton

            text: qsTr("Save")

            buttonColor: "#399F2E"

            onClicked: {
                Emp.updateEmployee(idField, firstnameField, lastnameField, usernameField, emailField, phoneField);
                savedText.visible = true

            }
        }

        CustomButton{
            id: passwordButton

            //width: 150
            text: qsTr("Change Password")

            buttonColor: "#6C261F"

            onClicked: Qt.quit()
        }
    }

    Text{
        id: savedText

        anchors.top: editGrid.bottom
        anchors.left: editGrid.left

        text: qsTr("Saved user...")

        color: "#399F2E"
        font.bold: true
        visible: false
    }
}
