import QtQuick 6.8
import QtQuick.Controls.Basic

CheckBox {
  id: myCheckBox

  text: myCheckBox.checked === true ? qsTr("true") : qsTr("false")
  font.pointSize: 11

  indicator: Rectangle {
    implicitWidth: 26
    implicitHeight: 26
    x: myCheckBox.leftPadding
    y: parent.height / 2 - height / 2
    radius: 3
    color: Style.backgroundColor
    border.color: Style.borderColor

    Rectangle {
      width: 14
      height: 14
      x: 6
      y: 6
      radius: 2
      color: myCheckBox.down ? Style.textColor : Qt.lighter(
                                      Style.textColor, 1.5)
      visible: myCheckBox.checked
    }
  }
  contentItem: Text {
    text: myCheckBox.text
    font: myCheckBox.font

    color: Style.textColor
    verticalAlignment: Text.AlignVCenter
    leftPadding: myCheckBox.indicator.width + myCheckBox.spacing
  }
}
