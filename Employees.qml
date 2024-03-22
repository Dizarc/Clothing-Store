import QtQuick 6.2
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
        console.log("Employee is"+username+" Id is: "+ tableView.currentIndex)
    }



    // ScrollView {
    //     id: viewEmployee

    //     width: parent.width / 2
    //     height: parent.height

        TableView {
            id: tableView

            width: parent.width / 2
            height: parent.height

            // header: Text {
            //     text: qsTr("Employees")
            //     font.pixelSize: 20
            //     color: "#ECEDF0"

            // }

            // highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
            // focus: true

            //selectionBehavior: tableView.SelectRows
            selectionModel: ItemSelectionModel {}

            model: Emp

            //  editDelegate: EmployeeEdit{}
            delegate: EmployeesDelegate{

                color: selected ? "blue" : "red"

                required property bool selected
            }
        }
    //}

    EmployeeEdit {
        id: editEmployee

        anchors.left: tableView.right

        visible: false

    }

}
