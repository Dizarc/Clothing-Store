import QtQuick 6.6
import QtQuick.Controls

import "EmployeesTab"
import "StorageTab"
import "HomeTab"

Item {
  id: applicationItem

  // x: parent.width
  // y: 0
  // SequentialAnimation {
  //     running: true

  //     NumberAnimation {
  //         target: applicationItem
  //         property: "x"
  //         easing.type: Easing.InSine
  //         to: 0
  //         duration: 300
  //     }
  // }

  Item{
    id: tabItem

    height: 30
    anchors.top: parent.top
    anchors.left: parent.left

    property int currentIndex: tabSwipeView.currentIndex

    Row{
      id: tabRow

      CustomButton{
        text: qsTr("Home")

        buttonColor: Qt.lighter(Style.backgroundColor, 1.5)

        onClicked: tabSwipeView.setCurrentIndex(0)

      }

      CustomButton{
        text: qsTr("Storage")

        buttonColor: Qt.lighter(Style.backgroundColor, 1.5)

        onClicked: tabSwipeView.setCurrentIndex(1)
      }

      CustomButton{
        text: qsTr("Employees")

        buttonColor: Qt.lighter(Style.backgroundColor, 1.5)

        onClicked: tabSwipeView.setCurrentIndex(2)
      }
    }

    Rectangle{
      id: underline

      anchors.top: tabRow.bottom

      width: 125
      height: 2

      color: Style.borderColor

      property real targetX: tabItem.currentIndex * underline.width

      NumberAnimation on x{
        duration: 200;
        to: underline.targetX;
        running: underline.x !== underline.targetX;
      }
    }
  }

  SwipeView{
    id: tabSwipeView

    anchors{
      top: tabItem.bottom
      topMargin: 10
      left: parent.left
      right: parent.right
      bottom: parent.bottom
    }

    currentIndex: tabItem.currentIndex
    interactive: false

    Item{
      Home{ }
    }

    Item{
      Storage{ }
    }

    Item{
      Employees{ }
    }
  }
}

