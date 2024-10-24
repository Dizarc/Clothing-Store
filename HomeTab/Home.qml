import QtQuick 6.6
import QtQuick.Controls.Basic
import QtQuick.Layouts

import "../Custom"

import com.company.TodoListModel

Item {
  id: homeItem

  anchors.fill: parent

  ColumnLayout {
    width: parent.width / 3
    height: parent.height

      ListView {
        id: todoPathView

        Layout.fillWidth: true
        Layout.fillHeight: true

        currentIndex: 0
        focus: true
        clip: true

        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds
        ScrollIndicator.vertical: ScrollIndicator {
          id: myScroll
          contentItem: Rectangle {
            implicitWidth: 2
            radius: 5
            color: myScroll.active ? Style.textColor : "transparent"
          }
        }

        model: TodoListModel

        delegate: TodoListDelegate {}
      }

    CustomButton {
      text: qsTr("Add to-do")
      Layout.alignment: Qt.AlignRight
      buttonColor: Style.generalButtonColor

      onClicked: {
        console.log("HEY")
      }
    }
  }
}
