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
  //required property bool selected

  width: 550
  height: 300
  opacity: PathView.iconOpacity
  focus: true
  clip: true

  color: done === 0 ? Style.backgroundColor : Qt.darker(Style.acceptButtonColor, 1.3)

  Column{
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

      onClicked:{
        console.log("123")
      }
    }
  }

  // MouseArea{
  //   id: todoListMouseArea

  //   anchors.fill: parent
  //   cursorShape: Qt.PointingHandCursor
  //   onClicked:{
  //     todoPathView.currentIndex = index
  //   }
  // }
}
