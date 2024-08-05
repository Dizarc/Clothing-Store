import QtQuick 6.6
import QtQuick.Controls
import QtQuick.Layouts

import com.company.Employees

import "../../ClothingStore"

Item {
  id: employeeItem

  anchors.fill: parent

  signal userClicked(int id,int index, string firstname, string lastname, string username, string email, string phone)

  onUserClicked: (id, index, firstname, lastname, username, email, phone) => {
                   editEmployee.idField = id;
                   editEmployee.employeeIndex = index;
                   editEmployee.firstnameField = firstname;
                   editEmployee.lastnameField = lastname;
                   editEmployee.usernameField = username;
                   editEmployee.emailField = email;
                   editEmployee.phoneField = phone;

                   //show edit and reset the visibility of the previous button presses.
                   employeeLayout.currentIndex = 1;
                   editEmployee.textVisibility = 0;
                 }

  GridLayout{
    id: employeeGrid

    width: parent.width / 2
    height: parent.height

    columns: 1
    rows: 3

    CustomButton{
      id: searchButton

      text: qsTr("Search Employee")
      buttonColor: Style.generalButtonColor

      onClicked: employeeLayout.currentIndex = 2
    }

    CustomButton{
      id: addEmployeeButton

      text: qsTr("Add Employee")
      buttonColor: Style.generalButtonColor

      onClicked: employeeLayout.currentIndex = 3
    }

    TableView {
      id: tableView

      Layout.topMargin: 20
      Layout.fillHeight: true
      Layout.fillWidth: true

      flickableDirection: Flickable.VerticalFlick
      boundsBehavior: Flickable.StopAtBounds

      selectionModel: ItemSelectionModel {
        id: selectionModel
      }

      model: Emp

      delegate: EmployeesDelegate {
        color: selected ? Qt.lighter(Style.backgroundColor, 2) : Style.backgroundColor
        required property bool selected
      }
    }
  }

  StackLayout{
    id: employeeLayout

    height: parent.height
    width: parent.width / 2

    anchors.left: employeeGrid.right
    anchors.leftMargin: 20

    Item {}
    EmployeeEdit { id: editEmployee }
    EmployeeSearch {}
    EmployeeAdd {}
  }
}
