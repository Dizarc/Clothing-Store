import QtQuick 6.8
import QtQuick.Layouts
import QtQuick.Controls.Basic

import com.company.Employees

import "../Custom"

Item {
  id: employeeAddItem

  Image {
    id: addImage

    anchors.horizontalCenter: addGrid.horizontalCenter

    source: "../images/addUserImage.png"

    sourceSize.width: 150
    sourceSize.height: 150
  }

  Text {
    id: addText

    anchors.horizontalCenter: addGrid.horizontalCenter
    anchors.top: addImage.bottom

    text: qsTr("Add Employee")

    color: Style.textColor
    font.pointSize: 15
  }

  GridLayout {
    id: addGrid

    anchors.top: addText.bottom
    anchors.topMargin: 10

    rows: 7
    columns: 2

    rowSpacing: 10
    columnSpacing: 30

    Text {
      text: qsTr("Firstname:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: firstnameAddInput
    }

    Text {
      text: qsTr("Lastname:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: lastnameAddInput
    }

    Text {
      text: qsTr("Username:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: usernameAddInput
    }

    Text {
      text: qsTr("Email:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: emailAddInput
    }

    Text {
      text: qsTr("Phone:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: phoneAddInput
    }

    Text {
      text: qsTr("Password:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: passwordAddInput
      echo: TextInput.Password
    }

    Text {
      text: qsTr("Re-enter password:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: repasswordAddInput
      echo: TextInput.Password
    }

    Text {
      text: qsTr("Is admin:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomCheckBox{
      id: isAdminCheckBox
    }

    CustomButton {
      text: qsTr("Add")

      buttonColor: Style.acceptButtonColor

      onClicked: {
        if(passwordAddInput.text === repasswordAddInput.text){
          if (Emp.add(firstnameAddInput.text, lastnameAddInput.text,
                              usernameAddInput.text, emailAddInput.text,
                              phoneAddInput.text, passwordAddInput.text,
                              isAdminCheckBox.checked)){

            empInfoDialog.dialogText = qsTr("Successfully added employee!")

            firstnameAddInput.text = ""
            lastnameAddInput.text = ""
            usernameAddInput.text = ""
            emailAddInput.text = ""
            phoneAddInput.text = ""
            passwordAddInput.text = ""
            repasswordAddInput.text = ""
            isAdminCheckBox.checkState = Qt.Unchecked
          }else
            empInfoDialog.dialogText = qsTr("Error while adding employee.\nMake sure username is unique!")
        }else
          empInfoDialog.dialogText = qsTr("Passwords do not match!")

        empInfoDialog.show()
      }
    }
  }
}
