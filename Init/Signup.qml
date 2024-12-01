import QtQuick 6.8
import QtQuick.Layouts

import "../Custom"

import com.company.DatabaseController

Item {
  id: signupItem

  GridLayout{
    id: addGrid

    anchors.verticalCenterOffset: -80
    anchors.centerIn: parent

    rows: 10
    columns: 2

    rowSpacing: 10
    columnSpacing: 30

    Image {
      source: "../images/logo.png"

      Layout.columnSpan: 2
      Layout.alignment: Qt.AlignHCenter

      fillMode: Image.PreserveAspectFit
      sourceSize.width: Window.width / 4
    }

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
      Keys.onReturnPressed: createButton.clicked()
    }

    CustomButton{
      id: createButton

      text: qsTr("Create User")

      buttonColor: Style.acceptButtonColor

      Keys.onReturnPressed: createButton.clicked()

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
