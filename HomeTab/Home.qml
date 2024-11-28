import QtQuick 6.8
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtGraphs

import "../Custom"

import com.company.TodoListModel
import com.company.LogData
import com.company.ClothesTypesModel
import com.company.ClothesModel
import com.company.SizesModel

RowLayout{
  id: homeItem

  anchors.fill: parent

  InfoDialog {
    id: homeInfoDialog
  }

  ColumnLayout{
    Layout.fillHeight: true
    Layout.preferredWidth: parent.width / 3
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
    id: graphColumn

    property int sizeSelected: -1

    Layout.preferredWidth: parent.width / 2
    Layout.fillHeight: true
    Layout.rightMargin: 5
    Layout.bottomMargin: 5

    ButtonGroup{
      id: radioGroup

      onClicked: {
        graphColumn.sizeSelected = -1
        sizesComboBox.currentIndex = -1
        sizesComboBox.displayText = qsTr("All")

        typesComboBox.currentIndex = -1
        typesComboBox.displayText = qsTr("All")

        clothesComboBox.currentIndex = -1
        clothesComboBox.displayText = qsTr("")

        graphsView.removeSeries(0)
        graphsView.addSeries(LogData.generateSeries("all", -1, -1, radioGroup.checkedButton.text))
      }
    }

    RowLayout{
      Layout.alignment: Qt.AlignVCenter
      Text {
        text: qsTr("Filter by date:")

        color: Style.textColor
        font.pointSize: 12
      }

      CustomRadioButton {
        checked: true
        text: qsTr("day")
        ButtonGroup.group: radioGroup
      }

      CustomRadioButton {
        text: qsTr("month")
        ButtonGroup.group: radioGroup
      }

      CustomRadioButton {
        text: qsTr("year")
        ButtonGroup.group: radioGroup
      }
    }

    GridLayout{
      rows: 3
      columns: 2

      Text {
        text: qsTr("Filter by size:")

        color: Style.textColor
        font.pointSize: 12
      }

      CustomComboBox{
        id: sizesComboBox

        currentIndex: -1
        displayText: qsTr("All")

        model: SizesModel

        delegate: ItemDelegate {
          id: sizeCbDelegate

          required property int sizeId
          required property string sizeName

          required property int index

          width: sizesComboBox.width
          implicitHeight: sizesComboBox.height

          highlighted: sizesComboBox.highlightedIndex === index

          contentItem: Text {
            text: sizeName
            color: Style.textColor
            font: sizesComboBox.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
          }

          background: Rectangle {
            color: sizeCbDelegate.pressed ? Qt.lighter(
                                              Style.generalButtonColor,
                                              1.2) : sizeCbDelegate.hovered ? Qt.lighter(
                                                                                Style.inputBoxColor,
                                                                                1.1) : Style.inputBoxColor
            border.color: Style.borderColor
            radius: 2
          }

          onClicked: {
            graphColumn.sizeSelected = sizeId
            sizesComboBox.displayText = sizeName
            sizesComboBox.currentIndex = index
            typesComboBox.displayText = qsTr("All")

            graphsView.removeSeries(0)
            graphsView.addSeries(LogData.generateSeries("all", -1, graphColumn.sizeSelected, radioGroup.checkedButton.text))
          }
        }
      }

      Text {
        text: qsTr("Filter by type:")

        color: Style.textColor
        font.pointSize: 12
      }

      CustomComboBox{
        id: typesComboBox

        currentIndex: -1
        displayText: qsTr("All")

        model: ClothesTypesModel

        delegate: ItemDelegate {
          id: typeCbDelegate

          required property int typeId
          required property string typeName

          required property int index

          width: typesComboBox.width
          implicitHeight: typesComboBox.height

          highlighted: typesComboBox.highlightedIndex === index

          contentItem: Text {
            text: typeName
            color: Style.textColor
            font: typesComboBox.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
          }

          background: Rectangle {
            color: typeCbDelegate.pressed ? Qt.lighter(
                                              Style.generalButtonColor,
                                              1.2) : typeCbDelegate.hovered ? Qt.lighter(
                                                                                Style.inputBoxColor,
                                                                                1.1) : Style.inputBoxColor
            border.color: Style.borderColor
            radius: 2
          }

          onClicked: {
            typesComboBox.displayText = typeName
            typesComboBox.currentIndex = index

            clothesComboBox.displayText = qsTr("All")
            ClothesModel.filterType(typeId)

            graphsView.removeSeries(0)
            graphsView.addSeries(LogData.generateSeries("type", typeId, graphColumn.sizeSelected, radioGroup.checkedButton.text))

          }
        }
      }

      Text {
        text: qsTr("Filter by clothing:")

        color: Style.textColor
        font.pointSize: 12
      }

      CustomComboBox{
        id: clothesComboBox

        currentIndex: -1
        enabled: typesComboBox.currentIndex !== -1 ? true : false
        model: ClothesModel

        delegate: ItemDelegate {
          id: clothesCbDelegate

          required property int clothingId
          required property string clothingName

          required property int index

          width: clothesComboBox.width
          implicitHeight: clothesComboBox.height

          highlighted: clothesComboBox.highlightedIndex === index

          contentItem: Text {
            text: clothingName
            color: Style.textColor
            font: clothesComboBox.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
          }

          background: Rectangle {
            color: clothesCbDelegate.pressed ? Qt.lighter(
                                                 Style.generalButtonColor,
                                                 1.2) : clothesCbDelegate.hovered ? Qt.lighter(
                                                                                      Style.inputBoxColor,
                                                                                      1.1) : Style.inputBoxColor
            border.color: Style.borderColor
            radius: 2
          }

          onClicked: {
            clothesComboBox.displayText = clothingName
            clothesComboBox.currentIndex = index

            graphsView.removeSeries(0)
            graphsView.addSeries(LogData.generateSeries("item", clothingId, graphColumn.sizeSelected, radioGroup.checkedButton.text))
          }
        }
      }
    }

    GraphsView {
      id: graphsView

      antialiasing: true

      Layout.fillHeight: true
      Layout.fillWidth: true

      axisX: DateTimeAxis{
        min: new Date(2024, 0, 0)
        max: new Date()
        labelFormat: "dd/MM/yyyy"
      }
      axisY: ValueAxis {
        min: 0
        max: 500
        tickInterval: 25
      }

      theme: GraphsTheme {
        backgroundVisible: false

        seriesColors: Style.textColor
        grid.mainColor: Style.inputBoxColor
        plotAreaBackgroundColor: Style.backgroundColor

        axisXLabelFont.pointSize: 10
        axisX.labelTextColor: Style.textColor
        axisX.mainColor: Style.textColor

        axisYLabelFont.pointSize: 10
        axisY.labelTextColor: Style.textColor
        axisY.mainColor: Style.textColor
      }

      Component.onCompleted: graphsView.addSeries(LogData.generateSeries("all", -1, -1, "day"))
    }
  }
}
