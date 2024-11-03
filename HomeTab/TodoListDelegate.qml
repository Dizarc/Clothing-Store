import QtQuick 6.8
import QtQuick.Controls.Basic
import QtQuick.Layouts

import com.company.TodoListModel

import "../Custom"

Rectangle {
  id: todoListDelegate

  required property int todoId
  required property string todoDescription
  required property int done

  required property int index

  anchors.horizontalCenter: todoPathView.horizontalCenter
  width: todoPathView.width
  height: 300

  opacity: PathView.isCurrentItem ? 1 : 0.5
  focus: true
  radius: 5
  border.color: Style.borderColor
  border.width: 2
  color: todoCheckBox.checkState !== Qt.Checked ? Style.backgroundColor : Qt.darker(Style.acceptButtonColor, 1.5)

  ColumnLayout{
    anchors.fill: parent

    TextArea {
      id: todoText

      readOnly: done
      Layout.fillHeight: true
      Layout.fillWidth: true
      wrapMode: Text.Wrap
      text: todoDescription
      font.pointSize: 14
      color: Style.textColor

      onTextChanged: {
        if (saveTodoButton.visible !== true
            && text !== todoDescription)
          saveTodoButton.visible = true
      }
    }

    RowLayout{
      Layout.margins: 5
      Layout.alignment: Qt.AlignBottom | Qt.AlignRight

      spacing: 10

      CustomButton{
        id: saveTodoButton

        text: qsTr("Save Description")
        buttonColor: Style.acceptButtonColor
        visible: false

        onClicked:{
          if(TodoListModel.changeDescription(index, todoText.text)){
            saveTodoButton.visible = false
            homeInfoDialog.dialogText = qsTr("Successfully changed description!")
          }else
            homeInfoDialog.dialogText = qsTr("Error while changing description!")

          homeInfoDialog.show()
        }
      }

      Text {
        text: qsTr("Done:")
        height: implicitHeight
        color: Style.textColor
        font.pointSize: 12
      }

      CustomCheckBox{
        id: todoCheckBox
        checked: done
        onCheckStateChanged: TodoListModel.changeDone(index,checked)
      }

      CustomButton{
        text: qsTr("Remove")
        buttonColor: Style.generalButtonColor

        onClicked:{
          deleteTodoDialog.index = index
          deleteTodoDialog.show()
        }
      }
    }
  }
}
