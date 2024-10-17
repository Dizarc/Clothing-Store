import QtQuick 6.6

import "../Custom"

Text {
  id: clothesInfoText

  text: qsTr("")
  font.pointSize: 15
  font.bold: true

  states: [
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
        clothesInfoText {
          text: qsTr("Failed to change image!")
          color: Style.denyButtonColor
        }
      }
    },
    State {
      name: "successDescriptionChange"
      PropertyChanges {
        clothesInfoText {
          text: qsTr("Changed description!")
          color: Style.acceptButtonColor
        }
      }
    },
    State {
      name: "failedDescriptionChange"
      PropertyChanges {
        clothesInfoText {
          text: qsTr("Failed to change description!")
          color: Style.denyButtonColor
        }
      }
    },
    State {
      name: "successTypeChange"
      PropertyChanges {
        clothesInfoText {
          text: qsTr("changed type!")
          color: Style.acceptButtonColor
        }
      }
    },
    State {
      name: "failedTypeChange"
      PropertyChanges {
        clothesInfoText {
          text: qsTr("failed to change type!")
          color: Style.denyButtonColor
        }
      }
    },
    State {
      name: "successChangeCount"
      PropertyChanges {
        clothesInfoText {
          text: qsTr("changed count of a size!")
          color: Style.acceptButtonColor
        }
      }
    },
    State {
      name: "failedChangeCount"
      PropertyChanges {
        clothesInfoText {
          text: qsTr("failed to change count of a size!")
          color: Style.denyButtonColor
        }
      }
    }
  ]
}
