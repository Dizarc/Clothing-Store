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

    PathView {
      id: todoPathView

      Layout.fillHeight: true
      Layout.fillWidth: true

      clip: true

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

      MouseArea{
        anchors.fill: parent
        onWheel: {
          todoPathView.incrementCurrentIndex()
        }
      }
    }
  }
}
