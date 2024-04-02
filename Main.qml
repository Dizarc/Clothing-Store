import QtQuick 6.6
import QtQuick.Controls
import QtQuick.Layouts

Window {
  id: appWindow

  title: "Clothes Application"

  visible: true
  color: Style.backgroundColor

  width: Screen.width
  height: Screen.height

  Item{
    id: brandName

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
        var application = component.createObject(appWindow,{ width: appWindow.width, height:appWindow.height});

        if(application === null)
          console.log("Error creating object");

        login.destroy();

      }
    }

  }

}
