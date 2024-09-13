import QtQuick 6.6

import "../Custom"

Text {
  id: clothesInfoText

  text: qsTr("")
  font.pointSize: 11
  font.bold: true

  states: [
    State {
      name: "successDelete"
      PropertyChanges {
        clothesInfoText {
          text: qsTr("Deleted!")
          color: Style.acceptButtonColor
        }
      }
    },
    State {
      name: "failedDelete"
      PropertyChanges {
        clothesInfoText {
          text: qsTr("Failed to delete!")
          color: Style.denyButtonColor
        }
      }
    },
    State {
      name: "successRename"
      PropertyChanges {
        clothesInfoText {
          text: qsTr("Renamed!")
          color: Style.acceptButtonColor
        }
      }
    },
    State {
      name: "failedRename"
      PropertyChanges {
        clothesInfoText {
          text: qsTr("Failed to rename!")
          color: Style.denyButtonColor
        }
      }
    },
    State {
      name: "successImageChange"
      PropertyChanges {
        clothesInfoText {
          text: qsTr("changed image!")
          color: Style.acceptButtonColor
        }
      }
    },
    State {
      name: "failedImageChange"
      PropertyChanges {
        clothesTypesOutputText {
          text: qsTr("Failed to change image!")
          color: Style.denyButtonColor
        }
      }
    },
    State {
      name: "successCreated"
      PropertyChanges {
        clothesTypesOutputText {
          text: qsTr("Created new item!")
          color: Style.acceptButtonColor
        }
      }
    }
  ]
}
