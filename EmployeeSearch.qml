import QtQuick 6.6
import QtQuick.Layouts

import com.company.Employees

Item {
  id: employeeSearchItem

  // property alias firstnameField: firstnameEdit.text
  // property alias lastnameField: lastnameEdit.text
  // property alias usernameField: usernameEdit.text
  // //property alias passwordField: passwordEdit.text
  // property alias emailField: emailEdit.text
  // property alias phoneField: phoneEdit.text

  Image {
    id: searchImage

    anchors.horizontalCenter: searchGrid.horizontalCenter

    source: "images/searchImage.png"

    sourceSize.width: 150
    sourceSize.height: 150
  }

  Text{
    id: searchText

    anchors.horizontalCenter: searchGrid.horizontalCenter
    anchors.top: searchImage.bottom
    anchors.topMargin: 20
    text: qsTr("Search Employee");

    color: Style.textColor
    font.pointSize: 15
  }

  GridLayout{
    id: searchGrid

    anchors.top: searchText.bottom
    anchors.topMargin: 10

    rows: 6
    columns: 2

    rowSpacing: 10
    columnSpacing: 50

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
        id: firstnameSearch

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
        id: lastnameSearch

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
        id: usernameSearch

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
        id: emailSearch

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
        id: phoneSearch

        anchors.fill: parent

        leftPadding: 5

        activeFocusOnTab: true

        color: Style.textColor
        font.pointSize: 12
        maximumLength: 25

      }
    }

    CustomButton{
      id: searchButton

      text: qsTr("Search")

      buttonColor: "#399F2E"

      // onClicked: Emp.searchEmployee(firstnameField,
      //                               lastnameField,
      //                               usernameField,
      //                               emailField,
      //                               phoneField);
    }
  }
}
