import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0

Window {
    id:wind
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


function getFriendsText(friends) {
    var resString = ""
    for(const friend of friends) {
        resString += friend + " , "
    }
    return resString.slice(0,2);
}

SwipeView {
    id:swiper
    anchors.fill: parent
    width: wind.width
    height: wind.height
    Item {

ListView {
    anchors.fill: parent
    model: mdl
    spacing: 2
    delegate:
        Row {
        width: parent.width
        height: 50
        spacing: 2

        Rectangle {
            width: 70
            height: parent.height
            border.width: 1
            Text {
                anchors.fill: parent
                text:rowId
            }
        }
        Rectangle {
            width: 100
            height: parent.height
            border.width: 1
            Text {
                anchors.fill: parent
                text:name
            }
        }
        Rectangle {
            width: 100
            height: parent.height
            border.width: 1
            Text {
                anchors.fill: parent
                text:surname
            }
        }
    }
    header: Row {
        width: parent.width
        height: 50
        spacing: 2
        Rectangle {
            width: 70
            height: parent.height
            border.width: 1
            Text {
                anchors.fill: parent
                text:"rowId"
            }
        }
        Rectangle {
            width: 100
            height: parent.height
            border.width: 1
            Text {
                anchors.fill: parent
                text:"name"
            }
        }
        Rectangle {
            width: 100
            height: parent.height
            border.width: 1
            Text {
                anchors.fill: parent
                text:"surname"
            }
        }
    }
}
}
Item {
    ListView {
        anchors.fill: parent
        model: mdl
        spacing: 2
        delegate:
        Row {
            width: parent.width
            height: 50
            spacing: 2
            Rectangle {
                width: 150
                height: parent.height
                border.width: 1
                Text {
                    anchors.fill: parent
                    text:getFriendsText(friends)
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
            header: Row {
                Rectangle {
                    width: 150
                    height: parent.height
                    border.width: 1
                    Text {
                        anchors.fill: parent
                        text:"friends"
                    }
                }}
    }

}
}
}
