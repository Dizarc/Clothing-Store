import QtQuick 6.8
import QtQuick.Controls
import QtQuick.Layouts

import "Init"
import "Custom"

import com.company.DatabaseController
import com.company.Employees

/*
  TODO: Fix graph label functionality which shows old labels and new labels together when graph is updated.
*/
Window {
  id: root

  title: qsTr("Seamless Manager")

  color: Style.backgroundColor
  visibility: Qt.WindowFullScreen

  property bool isAdminLogged: false

  onVisibilityChanged: {
    if(root.visibility === Window.Windowed){
      width = 950;
      height = 700;
      x = Screen.width/2 - width/2
      y = Screen.height/2 - height/2
    }
  }

  Component.onCompleted: {
    if (DbController.isEmployeeTableEmpty) {
      pageLoader.source = "Init/Signup.qml";
    } else {
      pageLoader.source = "Init/Login.qml";
    }
  }

  Loader {
    id: pageLoader

    anchors.fill: parent
  }

  Connections {
    target: DbController

    function onWrongLogin() {
      if (pageLoader.item && pageLoader.item.wrongLogin !== undefined)
        pageLoader.item.wrongLogin = true;
    }

    function onRightLogin() {
      isAdminLogged = DbController.isCurrentlyAdmin;
      Emp.select()
      pageLoader.source = "MainApplication.qml";
    }
  }
}
