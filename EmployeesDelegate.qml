import QtQuick 6.2
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
            //tableView.currentIndex = id - 1;
        }

        Row {
            id: empRow
            spacing: 5
            Rectangle{
                height: delegate.height
                width: 30
                color: tableView.isCurrentItem ? "black" : "red"
            }

            Image {
                source: "images/userImage.png"

                sourceSize.width: 100
                sourceSize.height: 20
            }

            Text {
                text: delegate.id

                color: "#ECEDF0"

                font.pointSize: 12
                width: 10
            }

            Text {
                text: delegate.firstname

                color: "#ECEDF0"

                font.pointSize: 12
                width: 100
            }

            Text{
                text: delegate.lastname

                color: "#ECEDF0"

                font.pointSize: 12
                width: 100
            }

            Text {
                text: delegate.email

                color: "#ECEDF0"

                font.pointSize: 12
                width: 250
            }

            Text {
                text: delegate.phone

                color: "#ECEDF0"

                font.pointSize: 12
                width: 50
            }
        }
    }
}
