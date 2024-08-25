import QtQuick 6.6
import QtQuick.Layouts

import com.company.Employees

import "../../ClothingStore"

Item {
  id: employeeSearchItem

  Image {
    id: searchImage

    anchors.horizontalCenter: searchGrid.horizontalCenter

    source: "../images/searchImage.png"

    sourceSize.width: 150
    sourceSize.height: 150
  }

  Text{
    id: searchText

    anchors.horizontalCenter: searchGrid.horizontalCenter
    anchors.top: searchImage.bottom

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
        id: firstnameSearchInput

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
        id: lastnameSearchInput

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
        id: usernameSearchInput

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
        id: emailSearchInput

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
        id: phoneSearchInput

        anchors.fill: parent

        leftPadding: 5

        activeFocusOnTab: true

        color: Style.textColor
        font.pointSize: 12
        maximumLength: 25

      }
    }

    CustomButton{
      text: qsTr("Search")

      buttonColor: Style.acceptButtonColor

       onClicked: Emp.searchEmployee(firstnameSearchInput.text,
                                     lastnameSearchInput.text,
                                     usernameSearchInput.text,
                                     emailSearchInput.text,
                                     phoneSearchInput.text);
    }

    CustomButton{
      text: qsTr("Reset Search")

      buttonColor: Style.generalButtonColor

      onClicked: Emp.searchEmployee('', '', '', '', '');
    }
  }
}
