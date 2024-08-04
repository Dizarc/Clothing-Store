import QtQuick 6.6
import QtQuick.Controls
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

  Item{
    id: brandItem

    anchors.top: parent.top
    anchors.right: parent.left

    Image{
      id: brandImage

      source: "/images/icon.png"

      sourceSize.width: 100
      sourceSize.height: 100
    }

    Rectangle{
      anchors.left: brandImage.right
      color: "red"
      height: 25
      width: 150
      Text{
        text: qsTr("Gentle Cloth")
        anchors.centerIn: parent
        color: Style.textColor

        font.bold: true
        font.underline: true
        font.pointSize: 15
      }
    }
  }

  Login{
    id: login

    width: parent.width
    height: parent.height

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
