import QtQuick 6.6
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "Init"
import "Custom"

import com.company.DatabaseController

/*
  TODO:
  1. Get the application to understand when an admin has logged in and implement only admin privileges(already started on it on DatabaseController class)
  2. Create a logout function and an exit application button after a login.
  3. dont forget to add to search a way to search for admins too!
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
      //isAdminLogged = DbController.isCurrentlyAdmin;
      //console.log(DbController.isCurrentlyAdmin);
      pageLoader.source = "MainApplication.qml";
    }
  }
}
