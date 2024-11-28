import QtQuick 6.8
import QtQuick.Controls
import QtQuick.Layouts

import "Init"
import "Custom"

import com.company.DatabaseController
import com.company.Employees

/*
  TODO: include a revert call in every submitAll for all the models
  TODO: make every query a prepared one
  TODO: finish home page with a logo on the bottom of the graph
  TODO: change application login Image
  BUG: application crashes when no items are in types and a user adds a new type
  BUG: When filter is changed in graph old bar labels stay for some reason
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
