import QtQuick 6.6
import QtQuick.Layouts

import com.company.Employees

import "../../ClothingStore"

Item {
  id: employeeAddItem

  property int textVisibility: 0

  Connections{
    target: Emp

    function onAddedEmployee(){
      textVisibility = 1;
    }

    function onNotAddedEmployee(){
      textVisibility = 2;
    }

  }
  Image {
    id: addImage

    anchors.horizontalCenter: addGrid.horizontalCenter

    source: "../images/addUserImage.png"

    sourceSize.width: 150
    sourceSize.height: 150
  }

  Text{
    id: addText

    anchors.horizontalCenter: addGrid.horizontalCenter
    anchors.top: addImage.bottom

    text: qsTr("Add Employee");

    color: Style.textColor
    font.pointSize: 15
  }

  GridLayout{
    id: addGrid

    anchors.top: addText.bottom
    anchors.topMargin: 10

    rows: 6
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

    CustomButton{
      id: searchButton

      text: qsTr("Add")

      buttonColor: Style.acceptButtonColor

      onClicked: Emp.addEmployee(firstnameAddInput.text,
                                 lastnameAddInput.text,
                                 usernameAddInput.text,
                                 emailAddInput.text,
                                 phoneAddInput.text,
                                 passwordAddInput.text);
    }
  }

  Text{
    id: buttonOutputText

    anchors.top: addGrid.bottom
    anchors.left: addGrid.left

    text: qsTr("")
    font.bold: true

    states: [
      State{
        name: "added"; when: textVisibility == 1
        PropertyChanges {
          buttonOutputText{
            text: qsTr("Added User!")
            color: "#399F2E"
          }
        }
      },
      State{
        name: "notAdded"; when: textVisibility == 2
        PropertyChanges {
          buttonOutputText{
            text: qsTr("Error while adding user!")
            color: "#399F2E"
          }
        }
      }
    ]
  }
}
