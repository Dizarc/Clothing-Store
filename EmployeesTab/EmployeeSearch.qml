import QtQuick 6.8
import QtQuick.Layouts
import QtQuick.Controls.Basic

import com.company.Employees

import "../../SeamlessManager"
import "../Custom"

Item {
  id: employeeSearchItem

  Image {
    id: searchImage

    anchors.horizontalCenter: searchGrid.horizontalCenter

    source: "../images/searchImage.png"

    sourceSize.width: 150
    sourceSize.height: 150
  }

  Text {
    id: searchText

    anchors.horizontalCenter: searchGrid.horizontalCenter
    anchors.top: searchImage.bottom

    text: qsTr("Search Employee")

    color: Style.textColor
    font.pointSize: 15
  }

  GridLayout {
    id: searchGrid

    anchors.top: searchText.bottom
    anchors.topMargin: 10

    rows: 6
    columns: 2

    rowSpacing: 10
    columnSpacing: 30

    Text {
      text: qsTr("Firstname:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: firstnameSearchInput
    }

    Text {
      text: qsTr("Lastname:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: lastnameSearchInput
    }

    Text {
      text: qsTr("Username:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: usernameSearchInput
    }

    Text {
      text: qsTr("Email:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: emailSearchInput
    }

    Text {
      text: qsTr("Phone:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomInputBox{
      id: phoneSearchInput
    }

    Text {
      text: qsTr("Is admin:")

      color: Style.textColor
      font.pointSize: 12
    }

    CustomComboBox {
      id: adminStatus

      model: [qsTr("All"), qsTr("Admins"), qsTr("Non admins")]

      delegate: ItemDelegate {
        id: adminStatusDelegate

        required property var model
        required property int index

        width: adminStatus.width
        implicitHeight: adminStatus.height

        highlighted: adminStatus.highlightedIndex === index

        contentItem: Text {
          text: adminStatusDelegate.model[adminStatus.textRole]
          color: Style.textColor
          font: adminStatus.font
          elide: Text.ElideRight
          verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
          color: adminStatusDelegate.pressed ? Qt.lighter(
                                        Style.generalButtonColor,
                                        1.2) : adminStatusDelegate.hovered ? Qt.lighter(
                                                                      Style.inputBoxColor,
                                                                      1.1) : Style.inputBoxColor
          border.color: Style.borderColor
          radius: 2
        }
      }
    }

    CustomButton {
      text: qsTr("Search")

      buttonColor: Style.acceptButtonColor

      onClicked: {
        var isAnAdmin = null
        if (adminStatus.currentIndex === 1)
          isAnAdmin = true
        else if (adminStatus.currentIndex === 2)
          isAnAdmin = false

        Emp.search(firstnameSearchInput.text, lastnameSearchInput.text,
                           usernameSearchInput.text, emailSearchInput.text,
                           phoneSearchInput.text, isAnAdmin)
      }
    }

    CustomButton {
      text: qsTr("Reset Search")

      buttonColor: Style.generalButtonColor

      onClicked: {
        firstnameSearchInput.text = ""
        lastnameSearchInput.text = ""
        usernameSearchInput.text = ""
        emailSearchInput.text = ""
        phoneSearchInput.text = ""
        adminStatus.currentIndex = 0

        Emp.search('', '', '', '', '', null)
      }
    }
  }
}
