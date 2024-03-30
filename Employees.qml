import QtQuick 6.6
import QtQuick.Controls

import com.company.Employees


/*

TODO:

    1. Make selection possible - DONE
    2. Add delete employee to edit employee
    3. Add a search employee button that opens up just like edit employee - KINDA DONE

*/
Item {
  id: employeeItem

  anchors.fill: parent

  /*
    visibility: show edit employee or search employee
    0: show neither
    1: show edit Employee
    2: show search Employee
  */
  property int visibility: 0

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
    visibility = 1;
    editEmployee.textVisibility = 0;
  }

  CustomButton{
    id: searchButton

    text: qsTr("Search Employee")

    buttonColor: Qt.lighter(Style.backgroundColor, 1.5)

    onClicked: visibility = 2

  }

  CustomButton{
    id: resetSearchButton

    text: qsTr("Reset Search")

    anchors.leftMargin: 5
    anchors.left: searchButton.right
    buttonColor: Qt.lighter(Style.backgroundColor, 1.5)

    onClicked: Emp.searchEmployee('', '', '', '', '');

  }

  TableView {
    id: tableView

    width: parent.width / 2
    height: parent.height
    anchors.top: searchButton.bottom
    anchors.topMargin: 20

    flickableDirection: Flickable.VerticalFlick

    selectionBehavior: TableView.SelectRows
    selectionMode: TableView.SingleSelection
    selectionModel: ItemSelectionModel {
      id: selectionModel
    }

    model: Emp

    delegate: EmployeesDelegate {
      color: selected ? Qt.lighter(Style.backgroundColor, 2.5) : Style.backgroundColor
      required property bool selected
    }
  }

  EmployeeEdit {
    id: editEmployee

    height: parent.height
    width: parent.width / 2

    anchors.left: tableView.right
    anchors.leftMargin: 20

    visible: visibility == 1 ? true : false
  }

  EmployeeSearch {
    id: searchEmployee

    height: parent.height
    width: parent.width / 2

    anchors.left: tableView.right
    anchors.leftMargin: 20
    visible: visibility == 2 ? true : false
  }
}
