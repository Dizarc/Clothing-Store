import QtQuick 6.6
import QtQuick.Controls

Switch {
  id: mySwitch

  implicitWidth: 60
  implicitHeight: 23

  text: Style.theme === Style.lightTheme ? qsTr("Light") : qsTr("Dark")
  checked: Style.theme === Style.lightTheme ? false : true

  indicator: Rectangle {
    anchors.fill: parent
    radius: 3

    color: mySwitch.checked ? Style.darkThemeColor : Style.lightThemeColor
    border.color: Style.borderColor

    Rectangle {
      x: mySwitch.checked ? parent.width - width : 0

      width: 22
      height: 23
      radius: 3

      Image {
        anchors.fill: parent
        source: "../images/themeIcon.png"
      }

      color: mySwitch.down ? "#cccccc" : (mySwitch.checked ?  Style.lightThemeColor : Style.darkThemeColor)
      border.color: Style.borderColor
    }
  }

  contentItem: Text {
    width: mySwitch.width
    text: mySwitch.text

    color: Style.textColor

    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: mySwitch.checked ? Text.AlignLeft : Text.AlignRight
  }

  onClicked: {
    if(Style.theme === Style.lightTheme)
      Style.theme = Style.darkTheme
    else
      Style.theme = Style.lightTheme
  }

}
