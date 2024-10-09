import QtQuick 6.6
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "Init"
import "Custom"

import com.company.DatabaseController

/*
  TODO:
    1. Make the cells for each clothing item bigger and add the name of the item below the image box
    3. add change category functionality to a clothing item
    4. Make all selected stuff be darker not lighter
    5. add scrollwheel to employee tab
*/
Window {
  id: root

  title: "Clothes Application"

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
      pageLoader.source = "MainApplication.qml";
    }
  }
}
