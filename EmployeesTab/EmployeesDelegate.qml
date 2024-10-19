import QtQuick 6.6
import QtQuick.Controls.Basic

import "../../ClothingStore"
import "../Custom"

Rectangle {
  id: employeesDelegate

  required property int id
  required property string firstname
  required property string lastname
  required property string username
  required property string password
  required property string email
  required property string phone
  required property bool isAdmin

  required property int index
  required property bool selected

  implicitWidth: tableView.width
  implicitHeight: 30

  anchors.margins: 4

  color: selected ? Qt.darker(
                      Style.backgroundColor,
                      1.2) : empMouseArea.containsMouse ? Qt.lighter(
                                                            Style.backgroundColor,
                                                            1.1) : Style.backgroundColor
  clip: true

  MouseArea {
    id: empMouseArea

    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true

    onClicked: {
      employeeLayout.currentIndex = 1
      editEmployee.idField = id
      editEmployee.employeeIndex = index
      editEmployee.firstnameField = firstname
      editEmployee.lastnameField = lastname
      editEmployee.usernameField = username
      editEmployee.emailField = email
      editEmployee.phoneField = phone
      editEmployee.oldPasswordField = ""
      editEmployee.newPasswordField = ""
      editEmployee.renewPasswordField = ""
      editEmployee.isAdminField = isAdmin

      editEmployee.textVisibility = ""
      addEmployee.textVisibility = ""

      selectionModel.select(tableView.index(employeesDelegate.index, 0),
                            ItemSelectionModel.SelectCurrent)
    }
  }

  Row {
    id: empRow

    spacing: 5

    Image {
      source: "../images/userImage.png"

      sourceSize.width: 125
      sourceSize.height: 20
    }

    Text {
      text: id

      color: Style.textColor
      font.pointSize: 12
      width: 30
      clip: true
    }

    Text {
      text: firstname

      color: Style.textColor
      font.pointSize: 12
      width: 150
      clip: true
    }

    Text {
      text: lastname

      color: Style.textColor
      font.pointSize: 12
      width: 150
      clip: true
    }

    Text {
      text: email

      color: Style.textColor
      font.pointSize: 12
      width: 300
      clip: true
    }

    Text {
      text: phone

      color: Style.textColor
      font.pointSize: 12
      width: 100
      clip: true
    }
  }
}
