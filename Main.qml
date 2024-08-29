import QtQuick 6.6
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "Init"
import "Custom"

import com.company.DatabaseController

/*
  TODO:
  1. Implement a add clothes types functionality with image insertion etc.
  2. Make UI seemless while switching from all the functionalities in the storage tab.
*/
Window {
  id: root

  title: "Clothes Application"

  visible: true
  color: Style.backgroundColor
  visibility: Qt.WindowFullScreen

  property bool isAdminLogged: false

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
      isAdminLogged = DbController.isCurrentlyAdmin;
      pageLoader.source = "MainApplication.qml";
    }
  }
}
