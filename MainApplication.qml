import QtQuick 6.8
import QtQuick.Controls

import "EmployeesTab"
import "StorageTab"
import "HomeTab"
import "Custom"

Item {
  id: applicationItem

  Item {
    id: tabItem

    height: 30
    anchors.top: parent.top
    anchors.left: parent.left

    property int currentIndex: tabSwipeView.currentIndex

    Row {
      id: tabRow

      spacing: 2
      CustomButton {
        text: qsTr("Home")

        buttonColor: Style.generalButtonColor

        onClicked: tabSwipeView.setCurrentIndex(0)
      }

      CustomButton {
        text: qsTr("Storage")

        buttonColor: Style.generalButtonColor

        onClicked: tabSwipeView.setCurrentIndex(1)
      }

      CustomButton {
        text: qsTr("Employees")

        buttonColor: Style.generalButtonColor

        onClicked: tabSwipeView.setCurrentIndex(2)
      }

      ThemeSwitch { }

      CustomButton{
        text: qsTr("Logout")

        implicitWidth: 65
        implicitHeight: 25
        buttonColor: Style.denyButtonColor

        onClicked: pageLoader.source = "Init/Login.qml"
      }

      CustomButton{
        text: qsTr("Exit")

        implicitWidth: 65
        implicitHeight: 25
        buttonColor: Style.denyButtonColor

        onClicked: Qt.quit()
      }
    }

    Rectangle {
      id: underline

      anchors.top: tabRow.bottom

      width: 127
      height: 2

      color: Style.borderColor

      property real targetX: tabItem.currentIndex * underline.width

      NumberAnimation on x {
        duration: 200
        to: underline.targetX
        running: underline.x !== underline.targetX
      }
    }
  }

  SwipeView {
    id: tabSwipeView

    anchors {
      top: tabItem.bottom
      topMargin: 10
      left: parent.left
      right: parent.right
      bottom: parent.bottom
    }

    currentIndex: tabItem.currentIndex
    interactive: false

    Item {
      Home {}
      visible: tabSwipeView.currentIndex === 0 ? true : false
    }

    Item {
      Storage {}
      visible:  tabSwipeView.currentIndex === 1 ? true : false
    }

    Item {
      Employees {}
      visible:  tabSwipeView.currentIndex === 2 ? true : false
    }
  }
}
