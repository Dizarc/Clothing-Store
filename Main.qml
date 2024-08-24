import QtQuick 6.6
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "Init"
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

  Login{
    id: login

    anchors.centerIn: parent

    Connections{
      target: dbController

      function onWrongLogin() {
        login.wrongLogin = true
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
