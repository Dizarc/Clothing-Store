import QtQuick 6.8
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

    CustomInputBox{
      id: firstnameAddInput
    }

    Text{
      text: qsTr("Lastname: ");

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: lastnameAddInput
    }

    Text{
      text: qsTr("Username: ");

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: usernameAddInput
    }

    Text{
      text: qsTr("Email: ");

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: emailAddInput
    }

    Text{
      text: qsTr("Phone: ");

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: phoneAddInput
    }

    Text{
      text: qsTr("Password: ");

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: passwordAddInput
      echo: TextInput.Password
    }

    Text{
      text: qsTr("Re enter password: ");

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: repasswordAddInput
      echo: TextInput.Password
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
        }else
          userCreationText.text = qsTr("Passwords do not match!");
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
