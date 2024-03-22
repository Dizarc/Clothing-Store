import QtQuick 6.6
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: appWindow

    title: "Clothes Application"

    visible: true
    color: "#252930"

    width: Screen.width
    height: Screen.height

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
