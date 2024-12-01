import QtQuick 6.8
import QtQuick.Controls
import QtQuick.Layouts

import com.company.Employees

import "../../SeamlessManager"
import "../Custom"

Item {
  id: employeeItem

  anchors.fill: parent

  Component.onCompleted: Emp.select()

  InfoDialog{
    id: empInfoDialog
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
      id: addButton

      enabled: isAdminLogged
      opacity: isAdminLogged ? 1 : 0.5

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
      ScrollIndicator.vertical: ScrollIndicator {
        id: myScroll
        contentItem: Rectangle {
          implicitWidth: 3
          radius: 5
          color: myScroll.active ? Style.textColor : "transparent"
        }
      }

      selectionModel: ItemSelectionModel {
        id: selectionModel
      }

      model: Emp

      delegate: EmployeesDelegate { }
    }

    StackLayout{
      id: employeeLayout

      Item {}
      EmployeeEdit { id: editEmployee }
      EmployeeSearch {}
      EmployeeAdd {id: add}
    }
  }
}
