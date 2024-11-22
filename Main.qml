import QtQuick 6.8
import QtQuick.Controls
import QtQuick.Layouts

import "Init"
import "Custom"

import com.company.DatabaseController
import com.company.Employees

/*
  TODO: Create a "model" for the graphs from sql table todoList
  TODO: include a revert call in every submitAll for all the models
  TODO: How to send the graph info into qml? Should i send it as a series or a list??
  TODO: find a way for the graph to show the counts of all items and down the line add extra functionality for showing counts only for specific clothing sizes etc.
  BUG: when app upgraded to qt 6.8 the clothes types right click menu got broken
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
