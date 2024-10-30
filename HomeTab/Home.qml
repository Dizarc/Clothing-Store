import QtQuick 6.6
import QtQuick.Controls.Basic
import QtQuick.Layouts

import "../Custom"

import com.company.TodoListModel

Item {
  id: homeItem

  anchors.fill: parent
  ColumnLayout{
    width: parent.width / 3
    height: parent.height

    CustomButton {
      text: qsTr("Add to-do")
      Layout.alignment: Qt.AlignRight
      buttonColor: Style.generalButtonColor

      onClicked: {
        console.log("HEY")
      }
    }
    ScrollView {
      Layout.fillHeight: true
      Layout.fillWidth: true


      //problem with showing scrollbar!
      contentHeight: availableHeight
      contentWidth: availableWidth

      ScrollBar.vertical: ScrollBar {
        id: myScroll

        interactive: true
        active:true
        contentItem: Rectangle {
          implicitWidth: 2
          radius: 5
          color: myScroll.active ? Style.textColor : "transparent"
        }
      }

      PathView {
        id: todoPathView
        focus: true
        anchors.fill: parent

        model: TodoListModel

        delegate: TodoListDelegate {}

        path: Path {
          startX: 320
          startY: 0

          PathAttribute {name: "iconOpacity"; value: 0.5}
          PathLine {x: 320; y: 350}
          PathAttribute {name: "iconOpacity"; value: 1.0}
          PathLine {x: 320; y: 1070}
          PathAttribute {name: "iconOpacity"; value: 0.5}
        }
      }
    }
  }
}
