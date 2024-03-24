import QtQuick 6.6
import QtQuick.Controls

import com.company.Employees


/*

TODO:

    1. Make selection possible
    2. Add delete employee to edit employee
    3. Add a search employee button that opens up just like edit employee(Stackview?)

*/
Item {
  id: employeeItem

  anchors.fill: parent

  property int visibility: 0

  signal userClicked(int id, string firstname, string lastname, string username, string password, string email, string phone)

  onUserClicked: (id, firstname, lastname, username, password, email, phone) => {
    editEmployee.idField = id
    editEmployee.firstnameField = firstname
    editEmployee.lastnameField = lastname
    editEmployee.usernameField = username
    //editEmployee.passwordField = password;
    editEmployee.emailField = email
    editEmployee.phoneField = phone

    visibility = 1

    //Select current item
    selectionModel.select(tableView.index(id - 1, 0), ItemSelectionModel.SelectCurrent)
  }

  CustomButton{
    id: searchButton

    text: qsTr("Search Employee")

    buttonColor: Qt.lighter(Style.backGround, 1.5)

    onClicked: visibility = 2

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
      color: selected ? Qt.lighter(Style.backGround, 2.5) : Style.backGround
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
