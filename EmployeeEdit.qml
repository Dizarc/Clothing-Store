import QtQuick 6.6
import QtQuick.Layouts
import QtQuick.Controls.Basic

import com.company.Employees

Item {
  id: employeeEditItem

  property int idField
  property alias firstnameField: firstnameInput.text
  property alias lastnameField: lastnameInput.text
  property alias usernameField: usernameInput.text
  property alias emailField: emailInput.text
  property alias phoneField: phoneInput.text

  property alias oldPasswordField: oldPasswordInput.text
  property alias newPasswordField: newPasswordInput.text

  Connections{
    target: Emp

    function onEditedEmployee(){
      savedText.visible = true;
      changedText.visible = false;
    }

    function onPasswordChanged(){
      savedText.visible = false;
      changedText.visible = true;
    }
  }

  Image {
    id: editImage

    anchors.horizontalCenter: editGrid.horizontalCenter

    source: "images/userImage.png"

    sourceSize.width: 150
    sourceSize.height: 150
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

    rows: 8
    columns: 2

    rowSpacing: 10
    columnSpacing: 30

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
        id: firstnameInput

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
        id: lastnameInput

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
        id: usernameInput

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
        id: emailInput

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
        id: phoneInput

        anchors.fill: parent

        leftPadding: 5

        activeFocusOnTab: true

        color: Style.textColor
        font.pointSize: 12
        maximumLength: 25

      }
    }
    Text{
      text: qsTr("Old Password:")

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
        id: oldPasswordInput

        anchors.fill: parent

        leftPadding: 5
        echoMode: TextInput.Password

        activeFocusOnTab: true

        color: Style.textColor
        font.pointSize: 12
        maximumLength: 25
      }
    }
    Text{
      text: qsTr("new Password:")

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
        id: newPasswordInput

        anchors.fill: parent

        leftPadding: 5
        echoMode: TextInput.Password

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

      onClicked: Emp.updateEmployee(idField,
                                    firstnameField,
                                    lastnameField,
                                    usernameField,
                                    emailField,
                                    phoneField);

    }

    CustomButton{
      id: passwordButton

      //width: 150
      text: qsTr("Change Password")

      buttonColor: "#6C261F"

      onClicked: Emp.changePasswordEmployee(idField,
                                            oldPasswordField,
                                            newPasswordField)
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

  Text{
    id: changedText

    anchors.top: editGrid.bottom
    anchors.left: editGrid.left

    text: qsTr("Changed password successfully...")

    color: "#399F2E"
    font.bold: true
    visible: false
  }

}
