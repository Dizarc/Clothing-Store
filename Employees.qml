import QtQuick 6.6
import QtQuick.Controls

import com.company.Employees

Item {
    id: employeeItem

    anchors.fill: parent

    signal userClicked(id: int, firstname: string, lastname: string,username: string, password: string, email: string, phone: string)

    onUserClicked: (id, firstname, lastname,username, password, email, phone) => {
        editEmployee.idField = id;
        editEmployee.firstnameField = firstname;
        editEmployee.lastnameField = lastname;
        editEmployee.usernameField = username;
        //editEmployee.passwordField = password;
        editEmployee.emailField = email;
        editEmployee.phoneField = phone;

        editEmployee.visible = true
        console.log("Employee is"+username+" Id is: "+ tableView.index)
    }

        TableView {
            id: tableView

            width: parent.width / 2
            height: parent.height

            clip: true

            // header: Text {
            //     text: qsTr("Employees")
            //     font.pixelSize: 20
            //     color: "#ECEDF0"

            // }

            //TODO: make selection possible
            selectionBehavior: TableView.SelectRows
            selectionMode: TableView.SingleSelection
            selectionModel: ItemSelectionModel {}

            model: Emp

            delegate: EmployeesDelegate{
                required property bool selected
                color: selected ? "blue" : "lightgray"

            }
        }

    EmployeeEdit {
        id: editEmployee

        anchors.left: tableView.right

        visible: false

    }

}
