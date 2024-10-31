import QtQuick 6.6
import QtQuick.Controls.Basic
import "../Custom"

Rectangle {
  id: todoListDelegate

  required property int todoId
  required property int empId
  required property string todoDescription
  required property int done

  required property int index

  width: 630
  height: 350
  opacity: PathView.iconOpacity
  focus: true

  color: done === 0 ? Style.backgroundColor : Qt.darker(Style.acceptButtonColor, 1.3)

  Column{
    anchors.leftMargin: 5
    anchors.fill: parent

    TextArea {
      readOnly: !isAdminLogged
      wrapMode: Text.WordWrap
      text: todoDescription
      font.pointSize: 12
      color: Style.textColor
    }

    CustomButton{
      text: "remove"
      width: 100
      buttonColor: Style.generalButtonColor
      onClicked:{
        console.log("123")
      }
    }
  }
}
