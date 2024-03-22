import QtQuick 6.6
import QtQuick.Controls

Item {
    id: applicationItem

    // x: parent.width
    // y: 0
    // SequentialAnimation {
    //     running: true

    //     NumberAnimation {
    //         target: applicationItem
    //         property: "x"
    //         easing.type: Easing.InSine
    //         to: 0
    //         duration: 300
    //     }
    // }

    Item{
        id: tabItem

        height: 30
        anchors.top: parent.top
        anchors.left: parent.left

        property int currentIndex: swipeView.currentIndex

        Row{
            id: tabRow

            spacing: 1

            CustomButton{
                text: qsTr("Home")

                buttonColor: "#3A3E44"

                onClicked: swipeView.setCurrentIndex(0)

            }

            CustomButton{
                text: qsTr("Storage")

                buttonColor: "#3A3E44"

                onClicked: swipeView.setCurrentIndex(1)
            }

            CustomButton{
                text: qsTr("Employees")

                buttonColor: "#3A3E44"

                onClicked: swipeView.setCurrentIndex(2)
            }
        }

        Rectangle{
            id: underline

            anchors.top: tabRow.bottom

            width: 100
            height: 2

            color:"#5D646D"

            property real targetX: tabItem.currentIndex * underline.width

            NumberAnimation on x{
                duration: 200;
                to: underline.targetX;
                running: underline.x !== underline.targetX;
            }
        }
    }


    SwipeView{
        id: swipeView

        anchors{
            top: tabItem.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        currentIndex: tabItem.currentIndex
        interactive: false

        Item{
            id: homeItem
            width: 400
            height:400

            Rectangle{
                width: 400
                height:400
                color:"red"
            }
        }

        Item{
            id: storageItem
            width: 400
            height:400

            Rectangle{
                width: 400
                height:400
                color:"blue"
            }

        }

        Item{

            Employees{

            }
        }



    }


}

