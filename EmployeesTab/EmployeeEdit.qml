import QtQuick 6.8
import QtQuick.Layouts
import QtQuick.Controls.Basic
import QtQuick.Dialogs

import com.company.Employees

import "../Custom"

Item {
  id: employeeEditItem

  property int employeeIndex
  property int idField
  property alias firstnameField: firstnameEditInput.text
  property alias lastnameField: lastnameEditInput.text
  property alias usernameField: usernameEditInput.text
  property alias emailField: emailEditInput.text
  property alias phoneField: phoneEditInput.text

  property alias oldPasswordField: oldPasswordEditInput.text
  property alias newPasswordField: newPasswordEditInput.text
  property alias renewPasswordField: renewPasswordEditInput.text

  property alias isAdminField: isAdminCheckBox.checked

  Image {
    id: editImage

    anchors.horizontalCenter: editGrid.horizontalCenter

    source: "../images/userImage.png"

    sourceSize.width: 150
    sourceSize.height: 150
  }

  Text {
    id: editText

    anchors.horizontalCenter: editGrid.horizontalCenter
    anchors.top: editImage.bottom

    text: qsTr("Edit Employee " + usernameField)

    color: Style.textColor
    font.pointSize: 15
  }

  GridLayout {
    id: editGrid

    anchors.top: editText.bottom
    anchors.topMargin: 10

    rows: 9
    columns: 2

    rowSpacing: 10
    columnSpacing: 30

    Text {
      text: qsTr("Firstname:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: firstnameEditInput
    }

    Text {
      text: qsTr("Lastname:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: lastnameEditInput
    }

    Text {
      text: qsTr("Username:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: usernameEditInput
    }

    Text {
      text: qsTr("Email:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: emailEditInput
    }

    Text {
      text: qsTr("Phone:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: phoneEditInput
    }

    Text {
      text: qsTr("Old password:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: oldPasswordEditInput
      echo: TextInput.Password
    }

    Text {
      text: qsTr("new password:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: newPasswordEditInput
      echo: TextInput.Password
    }

    Text {
      text: qsTr("re enter password:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: renewPasswordEditInput
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
      id: saveButton

      enabled: isAdminLogged
      opacity: isAdminLogged ? 1 : 0.5

      text: qsTr("Save")
      buttonColor: Style.acceptButtonColor

      onClicked: {
        if (Emp.update(employeeIndex, firstnameField, lastnameField,
                               usernameField, emailField, phoneField,
                               isAdminField))
          empInfoDialog.dialogText = qsTr("Saved user!")
        else
          empInfoDialog.dialogText = qsTr("failed to save user!")
        empInfoDialog.show()
      }
    }

    CustomButton {
      id: passwordButton

      enabled: isAdminLogged
      opacity: isAdminLogged ? 1 : 0.5

      text: qsTr("Change Password")
      buttonColor: Style.acceptButtonColor

      onClicked: {
        if(newPasswordEditInput.text === renewPasswordEditInput.text){
          if (Emp.changePassword(idField, oldPasswordField,
                                         newPasswordField))
            empInfoDialog.dialogText = qsTr("changed password!")
          else
            empInfoDialog.dialogText = qsTr("Error while changing password!\nCheck if the old password is correct!")
        }else{
          empInfoDialog.dialogText = qsTr("Passwords dont match!")
        }
        empInfoDialog.show()
      }
    }

    CustomButton {
      id: deleteButton

      enabled: isAdminLogged
      opacity: isAdminLogged ? 1 : 0.5

      text: qsTr("delete")
      buttonColor: Style.denyButtonColor
      onClicked: deleteDialog.show()
    }
  }

  ConfirmDialog{
    id: deleteDialog

    dialogText: qsTr("Are you sure you want to delete the employee: " + usernameField + "?")

    onClickedYes: {
      if (Emp.remove(employeeIndex)){
        empInfoDialog.dialogText = qsTr("Successfully deleted employee!")
        employeeLayout.currentIndex = 0;
      }
      else
        empInfoDialog.dialogText = qsTr("Error while deleting employee!")

      deleteDialog.close()
      empInfoDialog.show()
    }
  }
}
