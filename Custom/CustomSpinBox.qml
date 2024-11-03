import QtQuick 6.8
import QtQuick.Controls.Basic

SpinBox {
  id: customSpinBox

  implicitWidth: 80
  implicitHeight: 25

  editable: true
  value: from
  from: 1
  to: 100

  font.pointSize: 12

  contentItem: TextInput {
    z: 2
    text: customSpinBox.value
    font: customSpinBox.font

    color: Style.textColor
    selectionColor: Style.textColor
    selectedTextColor: Style.textColor

    horizontalAlignment: Qt.AlignHCenter
    verticalAlignment: Qt.AlignVCenter

    readOnly: !customSpinBox.editable
    validator: customSpinBox.validator
    inputMethodHints: Qt.ImhFormattedNumbersOnly
  }

  up.indicator: Rectangle {
    x: customSpinBox.mirrored ? 0 : parent.width - width
    height: parent.height
    implicitWidth: 20
    implicitHeight: 25

    color: customSpinBox.up.pressed ? Qt.lighter(
                                        Style.generalButtonColor,
                                        1.2) : customSpinBox.up.hovered ? Qt.lighter(
                                                                         Style.generalButtonColor,
                                                                         1.1) : Style.generalButtonColor
    border.color: Style.borderColor

    Text {
      text: "+"
      anchors.fill: parent

      font.bold: true
      font.pointSize: customSpinBox.font.pointSize
      color: Style.textColor

      fontSizeMode: Text.Fit
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      acceptedButtons: Qt.NoButton
    }
  }

  down.indicator: Rectangle {
    x: customSpinBox.mirrored ? parent.width - width : 0
    height: parent.height
    implicitWidth: 20
    implicitHeight: 25

    color: customSpinBox.down.pressed ? Qt.lighter(
                                          Style.generalButtonColor,
                                          1.2) : customSpinBox.down.hovered ? Qt.lighter(
                                                                           Style.generalButtonColor, 1.1) : Style.generalButtonColor
    border.color: Style.borderColor

    Text {
      text: "-"
      anchors.fill: parent

      font.bold: true
      font.pointSize: customSpinBox.font.pointSize
      color: Style.textColor

      fontSizeMode: Text.Fit
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      acceptedButtons: Qt.NoButton
    }
  }

  background: Rectangle {
    color: customSpinBox.pressed ? Qt.lighter(
                                     Style.inputBoxColor,
                                     1.2) : customSpinBox.hovered ? Qt.lighter(
                                                                      Style.inputBoxColor,
                                                                      1.1) : Style.inputBoxColor
    border.color: Style.borderColor
    radius: 2
  }
}
