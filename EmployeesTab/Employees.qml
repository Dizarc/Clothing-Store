import QtQuick 6.6
import QtQuick.Controls
import QtQuick.Layouts

import com.company.Employees

import "../../ClothingStore"

Item {
  id: employeeItem

  anchors.fill: parent

  signal userClicked(int id,int index, string firstname, string lastname, string username, string email, string phone, bool isAdmin)

  onUserClicked: (id, index, firstname, lastname, username, email, phone, isAdmin) => {
                   editEmployee.idField = id;
                   editEmployee.employeeIndex = index;
                   editEmployee.firstnameField = firstname;
                   editEmployee.lastnameField = lastname;
                   editEmployee.usernameField = username;
                   editEmployee.emailField = email;
                   editEmployee.phoneField = phone;
                   editEmployee.oldPasswordField = "";
                   editEmployee.newPasswordField = "";
                   editEmployee.renewPasswordField = "";
                   editEmployee.isAdminField = isAdmin;

                   employeeLayout.currentIndex = 1;
                   editEmployee.textVisibility = "";
                   addEmployee.textVisibility = "";
                 }

  GridLayout{
    id: employeeGrid

    anchors.fill: parent

    columns: 2
    rows: 3

    CustomButton{
      id: searchButton

      text: qsTr("Search Employee")
      buttonColor: Style.generalButtonColor

      onClicked: employeeLayout.currentIndex = 2
    }

    CustomButton{
      id: addEmployeeButton

      enabled: isAdminLogged

      Layout.row: 1
      Layout.column: 0
      text: qsTr("Add Employee")
      buttonColor: Style.generalButtonColor

      onClicked: employeeLayout.currentIndex = 3
    }

    TableView {
      id: tableView

      Layout.row: 2
      Layout.column: 0

      Layout.topMargin: 20
      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.maximumWidth: parent.width / 2

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

    StackLayout{
      id: employeeLayout

      Item {}
      EmployeeEdit { id: editEmployee }
      EmployeeSearch {}
      EmployeeAdd {id: addEmployee}
    }
  }
}
