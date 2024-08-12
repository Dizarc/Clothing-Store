import QtQuick 6.6
import QtQuick.Layouts
import QtQuick.Controls.Basic
import QtQuick.Dialogs

import com.company.Employees

import "../../ClothingStore"

Item {
  id: employeeEditItem

  /*
    textVisibility: which text to show
    0: dont show text
    1: show successful save text
    2: show successful password change
    3: show wrong password
    4: show sucessfull deleted message
  */
  property int textVisibility: 0

  property int employeeIndex
  property int idField
  property alias firstnameField: firstnameEditInput.text
  property alias lastnameField: lastnameEditInput.text
  property alias usernameField: usernameEditInput.text
  property alias emailField: emailEditInput.text
  property alias phoneField: phoneEditInput.text

  property alias oldPasswordField: oldPasswordEditInput.text
  property alias newPasswordField: newPasswordEditInput.text

  Connections{
    target: Emp

    function onEditedEmployee(){
      textVisibility = 1;
    }

    function onPasswordChanged(){
      textVisibility = 2;
    }

    function onWrongPassword(){
      textVisibility = 3;
    }

    function onDeletedEmployee(){
      textVisibility = 4;
    }
  }

  Image {
    id: editImage

    anchors.horizontalCenter: editGrid.horizontalCenter

    source: "../images/userImage.png"

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

      color: Qt.lighter(Style.backgroundColor, 1.5)
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput{
        id: firstnameEditInput

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

      color: Qt.lighter(Style.backgroundColor, 1.5)
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput{
        id: lastnameEditInput

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

      color: Qt.lighter(Style.backgroundColor, 1.5)
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput{
        id: usernameEditInput

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

      color: Qt.lighter(Style.backgroundColor, 1.5)
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput{
        id: emailEditInput

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

      color: Qt.lighter(Style.backgroundColor, 1.5)
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput{
        id: phoneEditInput

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

      color: Qt.lighter(Style.backgroundColor, 1.5)
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput{
        id: oldPasswordEditInput

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

      color: Qt.lighter(Style.backgroundColor, 1.5)
      border.color: Style.borderColor
      border.width: 1
      radius: 5

      TextInput{
        id: newPasswordEditInput

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
      buttonColor: Style.acceptButtonColor

      onClicked: Emp.updateEmployee(employeeIndex,
                                    firstnameField,
                                    lastnameField,
                                    usernameField,
                                    emailField,
                                    phoneField);
    }

    CustomButton{
      id: passwordButton

      text: qsTr("Change Password")
      buttonColor: Style.acceptButtonColor

      onClicked: Emp.changePasswordEmployee(idField,
                                            oldPasswordField,
                                            newPasswordField)
    }

    CustomButton{
      id: deleteButton

      text: qsTr("delete")
      buttonColor: Style.denyButtonColor
      onClicked: popup.open()
    }
  }

  Dialog{
    id: popup

    anchors.centerIn: Overlay.overlay
    title: qsTr("Are you sure you want to delete the employee: " + usernameField + "?");

    modal: true

    footer: DialogButtonBox{

      delegate: CustomButton{
        buttonColor: Style.generalButtonColor
      }

      standardButtons: Dialog.Yes | Dialog.Cancel
    }



    background: Rectangle{
      color: Qt.darker(Style.backgroundColor, 1.5)
      border.color: Style.borderColor
    }

    onAccepted: {
      Emp.deleteEmployee(employeeIndex);
      popup.close();
    }

    onRejected: popup.close();
  }

  Text{
    id: buttonOutputText

    anchors.top: editGrid.bottom
    anchors.left: editGrid.left

    text: qsTr("")
    font.bold: true

    states: [
      State{
        name: "saved"; when: textVisibility == 1
        PropertyChanges {
          buttonOutputText{
            text: qsTr("Saved user!")
            color: "#399F2E"
          }
        }
      },
      State{
        name: "correctPassword"; when: textVisibility == 2
        PropertyChanges {
          buttonOutputText{
            text: qsTr("Changed password successfully!")
            color: "#399F2E"
          }
        }
      },
      State{
        name: "wrongPassword"; when: textVisibility == 3
        PropertyChanges {
          buttonOutputText{
            text: qsTr("Wrong password try again!")
            color: "#B21B00"
          }
        }
      },
      State{
        name: "delete"; when: textVisibility == 4
        PropertyChanges {
          buttonOutputText{
            text: qsTr("Employee deleted successfully!")
            color: "#399F2E"
          }
        }
      }
    ]
  }

}
