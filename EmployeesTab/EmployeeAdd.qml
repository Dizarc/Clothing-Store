import QtQuick 6.6
import QtQuick.Layouts
import QtQuick.Controls.Basic

import com.company.Employees

import "../../ClothingStore"

Item {
  id: employeeAddItem

  property alias textVisibility: buttonOutputText.state

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

    CheckBox{
      id: isAdminCheckBox

      text: isAdminCheckBox.checked === true ? qsTr("true") :  qsTr("false")
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
                  color: isAdminCheckBox.down ? Style.textColor : Qt.lighter( Style.textColor, 1.5)
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
      text: qsTr("Add")

      buttonColor: Style.acceptButtonColor

      onClicked: {
        if(passwordAddInput.text === repasswordAddInput.text){
          if (Emp.addEmployee(firstnameAddInput.text, lastnameAddInput.text,
                              usernameAddInput.text, emailAddInput.text,
                              phoneAddInput.text, passwordAddInput.text,
                              isAdminCheckBox.checked))
            buttonOutputText.state = "added"
          else
            buttonOutputText.state = "notAdded"
        }else
          buttonOutputText.state = "notMatchingPasswords"
      }
    }
  }

  Text {
    id: buttonOutputText

    anchors.top: addGrid.bottom
    anchors.left: addGrid.left

    text: qsTr("")
    font.bold: true

    states: [
      State {
        name: "added"
        PropertyChanges {
          buttonOutputText {
            text: qsTr("Added User!")
            color: Style.acceptButtonColor
          }
        }
      },
      State {
        name: "notAdded"
        PropertyChanges {
          buttonOutputText {
            text: qsTr("Error while adding user!\nMake sure username is unique!")
            color: Style.denyButtonColor
          }
        }
      },
      State {
        name: "notMatchingPasswords"
        PropertyChanges {
          buttonOutputText {
            text: qsTr("Passwords do not match!")
            color: Style.denyButtonColor
          }
        }
      }
    ]
  }
}
