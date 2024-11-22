import QtQuick 6.8
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtGraphs

import "../Custom"

import com.company.TodoListModel

RowLayout{
  id: homeItem

  anchors.fill: parent

  InfoDialog {
    id: homeInfoDialog
  }

  ColumnLayout{
    Layout.fillHeight: true
    Layout.maximumWidth: parent.width / 2
    Layout.leftMargin: 5
    Layout.bottomMargin: 5

    CustomButton {
      text: qsTr("Add to-do")

      buttonColor: Style.generalButtonColor

      onClicked: {
        if(TodoListModel.add())
          homeInfoDialog.dialogText = qsTr("Successfully added todo item!")
        else
          homeInfoDialog.dialogText = qsTr("Error while adding todo item!")

        homeInfoDialog.show()
      }
    }

    PathView {
      id: todoPathView

      Layout.fillHeight: true
      Layout.fillWidth: true
      Layout.leftMargin: 10
      Layout.rightMargin: 10

      clip: true
      pathItemCount: 3
      model: TodoListModel

      delegate: TodoListDelegate {}

      path: Path {
        startY: 150
        PathLine { y:  300}
        PathLine { y: 1080}
      }

      WheelHandler {
        onWheel: (event) => {
          if(event.angleDelta.y < 0)
            todoPathView.incrementCurrentIndex()
          else if(event.angleDelta.y > 0)
            todoPathView.decrementCurrentIndex()
        }
      }
    }

    ConfirmDialog {
      id: deleteTodoDialog

      property int index: -1

      dialogText: qsTr("Are you sure you want to delete this todo item?")

      onClickedYes: {
        if(TodoListModel.remove(index)){
          homeInfoDialog.dialogText = qsTr("Successfully deleted todo item!")
        }else
          homeInfoDialog.dialogText = qsTr("Error while deleting todo item!")

          deleteTodoDialog.close()
          homeInfoDialog.show()
      }
    }
  }

  ColumnLayout{
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.rightMargin: 5
    Layout.bottomMargin: 5

    // GraphData{
    //   id: graph1
    // }

    GraphsView {
      Layout.fillHeight: true
      Layout.fillWidth: true

      theme: GraphsTheme {
        colorScheme: GraphsTheme.ColorScheme.Dark
        theme: GraphsTheme.Theme.QtGreen
      }
      axisX: ValueAxis {
        min: 0
        tickInterval: 10
        max: 5
      }
      axisY: ValueAxis {
        min: 0
        max: 5
        tickInterval: 10
      }

      //Component.onCompleted: addSeries(graph1.series)

      LineSeries {
        name: "Line"

        XYPoint { x: 0; y: 0 }
        XYPoint { x: 1.1; y: 2.1 }
        XYPoint { x: 1.9; y: 3.3 }
        XYPoint { x: 2.1; y: 2.1 }
        XYPoint { x: 2.9; y: 4.9 }
        XYPoint { x: 3.4; y: 3.0 }
        XYPoint { x: 4.1; y: 3.3 }
      }
    }

    GraphsView {
      Layout.fillHeight: true
      Layout.fillWidth: true

      theme: GraphsTheme {
        colorScheme: GraphsTheme.ColorScheme.Dark
        theme: GraphsTheme.Theme.QtGreen
      }

      axisX: ValueAxis {
        min: 0
        tickInterval: 10
        max: 5
      }

      axisY: ValueAxis {
        min: 0
        max: 5
        tickInterval: 10
      }

      LineSeries {
        name: "Line"
        XYPoint { x: 0; y: 0 }
        XYPoint { x: 1.1; y: 2.1 }
        XYPoint { x: 1.9; y: 3.3 }
        XYPoint { x: 2.1; y: 2.1 }
        XYPoint { x: 2.9; y: 4.9 }
        XYPoint { x: 3.4; y: 3.0 }
        XYPoint { x: 4.1; y: 3.3 }
      }
    }
  }
}
