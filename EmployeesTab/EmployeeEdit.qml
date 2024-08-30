import QtQuick 6.6
import QtQuick.Layouts
import QtQuick.Controls.Basic
import QtQuick.Dialogs

import com.company.Employees

import "../../ClothingStore/Custom"

Item {
  id: employeeEditItem

  property alias textVisibility: buttonOutputText.state

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

    CheckBox {
      id: isAdminCheckBox

      text: isAdminCheckBox.checked === true ? qsTr("true") : qsTr("false")
      font.pointSize: 11

      indicator: Rectangle {
        implicitWidth: 26
        implicitHeight: 26
        x: isAdminCheckBox.leftPadding
        y: parent.height / 2 - height / 2
        radius: 3
        color: Style.backgroundColor
        border.color: Style.borderColor

        Rectangle {
          width: 14
          height: 14
          x: 6
          y: 6
          radius: 2
          color: isAdminCheckBox.down ? Style.textColor : Qt.lighter(
                                          Style.textColor, 1.5)
          visible: isAdminCheckBox.checked
        }
      }
      contentItem: Text {
        text: isAdminCheckBox.text
        font: isAdminCheckBox.font

        color: Style.textColor
        verticalAlignment: Text.AlignVCenter
        leftPadding: isAdminCheckBox.indicator.width + isAdminCheckBox.spacing
      }
    }

    CustomButton {
      id: saveButton

      enabled: isAdminLogged

      text: qsTr("Save")
      buttonColor: Style.acceptButtonColor

      onClicked: {
        if (Emp.updateEmployee(employeeIndex, firstnameField, lastnameField,
                               usernameField, emailField, phoneField,
                               isAdminField))
          buttonOutputText.state = "successSave"
        else
          buttonOutputText.state = "failedSave"
      }
    }

    CustomButton {
      id: passwordButton

      enabled: isAdminLogged

      text: qsTr("Change Password")
      buttonColor: Style.acceptButtonColor

      onClicked: {
        if(newPasswordEditInput.text === renewPasswordEditInput.text){
          if (Emp.changePasswordEmployee(idField, oldPasswordField,
                                         newPasswordField))
            buttonOutputText.state = "successPasswordChange"
          else
            buttonOutputText.state = "failedPasswordChange"
        }else{
          buttonOutputText.state = "passwordNotSame"
        }
      }
    }

    CustomButton {
      id: deleteButton

      enabled: isAdminLogged

      text: qsTr("delete")
      buttonColor: Style.denyButtonColor
      onClicked: popup.open()
    }
  }

  Dialog {
    id: popup

    anchors.centerIn: Overlay.overlay
    title: qsTr(
             "Are you sure you want to delete the employee: " + usernameField + "?")

    modal: true

    footer: DialogButtonBox {

      delegate: CustomButton {
        buttonColor: Style.generalButtonColor
      }

      standardButtons: Dialog.Yes | Dialog.Cancel
    }

    background: Rectangle {
      color: Qt.darker(Style.backgroundColor, 1.5)
      border.color: Style.borderColor
    }

    onAccepted: {
      if (Emp.deleteEmployee(employeeIndex))
        buttonOutputText.state = "successDelete"
      else
        buttonOutputText.state = "failedDelete"

      popup.close()
    }

    onRejected: popup.close()
  }

  Text {
    id: buttonOutputText

    anchors.top: editGrid.bottom
    anchors.left: editGrid.left

    text: qsTr("")
    font.bold: true

    states: [
      State {
        name: "nothing"
        PropertyChanges {
          buttonOutputText {
            text: qsTr("")
          }
        }
      },
      State {
        name: "successSave"
        PropertyChanges {
          buttonOutputText {
            text: qsTr("Saved user!")
            color: Style.acceptButtonColor
          }
        }
      },
      State {
        name: "failedSave"
        PropertyChanges {
          buttonOutputText {
            text: qsTr(
                    "Failed to save user! \n Make sure username does not already exist!")
            color: Style.denyButtonColor
          }
        }
      },
      State {
        name: "successPasswordChange"
        PropertyChanges {
          buttonOutputText {
            text: qsTr("Changed password successfully!")
            color: Style.acceptButtonColor
          }
        }
      },
      State {
        name: "failedPasswordChange"
        PropertyChanges {
          buttonOutputText {
            text: qsTr("Wrong password try again!")
            color: Style.denyButtonColor
          }
        }
      },
      State {
        name: "passwordNotSame"
        PropertyChanges {
          buttonOutputText {
            text: qsTr("new password does not match!")
            color: Style.denyButtonColor
          }
        }
      },
      State {
        name: "successDelete"
        PropertyChanges {
          buttonOutputText {
            text: qsTr("Employee deleted successfully!")
            color: Style.acceptButtonColor
          }
        }
      },
      State {
        name: "failedDelete"
        PropertyChanges {
          buttonOutputText {
            text: qsTr("Employee was not deleted!")
            color: Style.denyButtonColor
          }
        }
      }
    ]
  }
}
