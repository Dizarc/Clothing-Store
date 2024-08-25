import QtQuick 6.6
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "Init"
import "Custom"

import com.company.DatabaseController


/*
  TODO:
  1. Make it so if there are no employees in the employees table make the user create an account.
  2. Implement a forgot my password feature!
  3. Create a logout function and an exit application button after a login.
  4. Make usernames be unique and that someone cant just add a new user with an existing username.
*/
Window {
  id: root

  title: "Clothes Application"

  visible: true
  color: Style.backgroundColor
  visibility: Qt.WindowFullScreen

  Loader {
    id: pageLoader

    anchors.fill: parent
  }

  Component.onCompleted: {
    if (DbController.isEmployeeTableEmpty) {
      pageLoader.source = "Init/Signup.qml";
    } else {
      pageLoader.source = "Init/Login.qml";
    }
  }
  Connections {
    target: DbController

    function onWrongLogin() {
      if (pageLoader.item && pageLoader.item.wrongLogin !== undefined)
        pageLoader.item.wrongLogin = true;
    }

    function onRightLogin() {
      pageLoader.source = "MainApplication.qml";
    }
  }
}
