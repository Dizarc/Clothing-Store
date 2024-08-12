import QtQuick 6.6
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "Init"

/*
  TODO:
  1. Make it so if there are no employees in the employees table make the user create an account.
  2. Implement a forgot my password feature!
  3. make it so the search add and edit employee works as a popup if the window size is small and they cant be seen.
*/
Window {
  id: root

  title: "Clothes Application"

  visible: true
  color: Style.backgroundColor

  visibility: Qt.WindowFullScreen

  Login{
    id: login

    anchors.centerIn: parent

    Connections{
      target: db

      function onWrongLogin() {
        login.wrongLoginText = true
      }

      function onRightLogin(){

        var component = Qt.createComponent("MainApplication.qml");
        var application = component.createObject(root,{ width: root.width, height: root.height});

        if(application === null)
          console.log("Error creating object");

        login.destroy();

      }
    }

  }

}
