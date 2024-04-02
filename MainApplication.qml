import QtQuick 6.6
import QtQuick.Controls

import "EmployeesTab"
import "StorageTab"

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

      spacing: 1

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

      color: Qt.lighter(Style.backgroundColor, 2)

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
      left: parent.left
      right: parent.right
      bottom: parent.bottom
    }

    currentIndex: tabItem.currentIndex
    interactive: false

    Item{
      id: homeItem
      width: 400
      height:400

      Rectangle{
        width: 400
        height:400
        color:"red"
      }
    }

    Item{
      Storage{ }
    }

    Item{
      Employees{ }
    }
  }
}

