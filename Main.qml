import QtQuick 6.6
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "Init"
import "Custom"

import com.company.DatabaseController
import com.company.Employees

/*
  TODO: create home tab with graphs about total items etc and a store todo list
*/
Window {
  id: root

  title: qsTr("Clothes Application")

  visible: true
  color: Style.backgroundColor
  visibility: Qt.WindowFullScreen

  property bool isAdminLogged: false

  onVisibilityChanged: {
    if(root.visibility === Window.Windowed){
      width = 700;
      height = 500;
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
