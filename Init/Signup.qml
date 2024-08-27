import QtQuick 6.6
import QtQuick.Layouts

import "../Custom"

import com.company.DatabaseController

Item {
  id: signupItem

  GridLayout{
    id: addGrid

    anchors.centerIn: parent

    rows: 9
    columns: 2

    rowSpacing: 10
    columnSpacing: 30

    Text{

      Layout.columnSpan: 2
      text: qsTr("Create an admin user ");

      color: Style.textColor
      font.pointSize: 15
    }

    Text{
      text: qsTr("Firstname: ");

      color: Style.textColor
      font.pointSize: 12
    }

    Rectangle{
      width: 300
      height: 25

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput{
        id: firstnameAddInput

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

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput{
        id: lastnameAddInput

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

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput{
        id: usernameAddInput

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

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput{
        id: emailAddInput

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

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput{
        id: phoneAddInput

        anchors.fill: parent

        leftPadding: 5

        activeFocusOnTab: true

        color: Style.textColor
        font.pointSize: 12
        maximumLength: 25
      }
    }

    Text{
      text: qsTr("Password: ");

      color: Style.textColor
      font.pointSize: 12
    }

    Rectangle{

      width: 300
      height: 25

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput{
        id: passwordAddInput

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
      text: qsTr("Re enter password: ");

      color: Style.textColor
      font.pointSize: 12
    }

    Rectangle{
      width: 300
      height: 25

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput{
        id: repasswordAddInput

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
      text: qsTr("Create User")

      buttonColor: Style.acceptButtonColor

      onClicked: {
        if(passwordAddInput.text == repasswordAddInput.text){
          if(!DbController.createAdminUser(firstnameAddInput.text,
                                                    lastnameAddInput.text,
                                                    usernameAddInput.text,
                                                    emailAddInput.text,
                                                    phoneAddInput.text,
                                                    passwordAddInput.text))
            userCreationText.text = qsTr("Error creating account!");

        }else{
          userCreationText.text = qsTr("Passwords do not match!");
        }
      }
    }

    Text{
      id: userCreationText
      text: qsTr("");
      color: Style.denyButtonColor
      font.pointSize: 12
    }
  }
}
