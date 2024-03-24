import QtQuick 6.6
import QtQuick.Controls.Basic

Rectangle {
  id: delegate

  implicitWidth: tableView.width
  implicitHeight: 30

  anchors.margins: 4

  clip: true

  required property int id
  required property string firstname
  required property string lastname
  required property string username
  required property string password
  required property string email
  required property string phone

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor

    onClicked : {
      userClicked(delegate.id, delegate.firstname, delegate.lastname, delegate.username, delegate.password, delegate.email, delegate.phone)

    }

    Row {
      id: empRow
      spacing: 5

      Image {
        source: "images/userImage.png"

        sourceSize.width: 125
        sourceSize.height: 20
      }

      Text {
        text: delegate.id

        color: Style.textColor

        font.pointSize: 12
        width: 30
      }

      Text {
        text: delegate.firstname

        color: Style.textColor

        font.pointSize: 12
        width: 150
      }

      Text{
        text: delegate.lastname

        color: Style.textColor

        font.pointSize: 12
        width: 150
      }

      Text {
        text: delegate.email

        color: Style.textColor

        font.pointSize: 12
        width: 300
      }

      Text {
        text: delegate.phone

        color: Style.textColor

        font.pointSize: 12
        width: 100
      }
    }
  }
}
