import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 2.0
import Qt.labs.qmlmodels 1.0
import QtQuick.Dialogs 1.0
import "DBFunctions.js" as DbFunctions

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    property int cellHorizontalSpacing: 10
    property var db

    SwipeView {
        id:swiper
        anchors.fill: parent
        Item {
    TableModel {
    id: tableModel
    TableModelColumn { display: "id" }
    TableModelColumn { display: "first_name" }
    TableModelColumn { display: "last_name" }
    TableModelColumn { display: "email" }
    TableModelColumn { display: "phone" }
    rows: []
    }

    TableView {
    id: table
    anchors.fill: parent
    columnSpacing: 1
    rowSpacing: 1
    model: tableModel
    delegate: Rectangle {
    implicitWidth: Math.max(100, /*left*/ cellHorizontalSpacing + innerText.width + /*right*/
    cellHorizontalSpacing)
    implicitHeight: 50
    border.width: 1
    Text {
    id: innerText
    text: display
    anchors.centerIn: parent
    }
    }
}
        }
        Item {
            Column {
            anchors.fill: parent
            spacing: 5
            TextField {
            id: firstName
            placeholderText: "Имя"
            }
            TextField {
            id: lastName
            placeholderText: "Фамилия"
            }
            TextField {
            id: email
            placeholderText: "E-mail"
            }
            TextField {
            id: phone
            placeholderText: "Номер телефона"
            }
            }
            Button {
            id: button
            text: "Добавить человека"
            width: parent.width
            height: 50
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked:  {
                try {
                db.transaction((tx) => {
                var resObj = DbFunctions.addContact(tx, firstName.text, lastName.text, email.text, phone.text);
                if (resObj.rowsAffected !== 0) {
                tableModel.appendRow({
                id: resObj.insertId,
                first_name: firstName.text,
                last_name: lastName.text,
                email: email.text,
                phone: phone.text
                })
                }
                })
                } catch (err) {
                console.log("Error creating or updating table in database: " + err)
                }
                }

            }
        }
        Item {
            Column {
            anchors.fill: parent
            spacing: 5
            TextField {
            id: updateID
            placeholderText: "ID"
            }
            TextField {
            id: updatefirstName
            placeholderText: "Имя"
            }
            TextField {
            id: updatelastName
            placeholderText: "Фамилия"
            }
            TextField {
            id: updateemail
            placeholderText: "E-mail"
            }
            TextField {
            id: updatephone
            placeholderText: "Номер телефона"
            }
            }
            Button {
            id: updatebutton
            text: "Обновить человека"
            width: parent.width
            height: 50
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked:  {
                try {
                db.transaction((tx) => {
                var resObj = DbFunctions.updateContact(tx, firstName.text, lastName.text, email.text, phone.text,updateID.text);
                })
                } catch (err) {
                console.log("Error creating or updating table in database: " + err)
                }
                }

            }
        }
    }
    ComboBox {
        id:combo
        model: ListModel {
            id: model
            ListElement { text: "DBExample" }
            ListElement { text: "DBExample2" }
            ListElement { text: "DBExample3" }
        }
    }





    Component.onCompleted: {
        var data_array = ListModel
        db = LocalStorage.openDatabaseSync(combo.currentText, "1.0", "Пример локальной базы данных", 1000)
   // var db = LocalStorage.openDatabaseSync("DBExample", "1.0", "Пример локальной базы данных",
    //1000)
        try {
        db.transaction((tx) => { DbFunctions.readContacts(tx, table.model) })
        } catch (err) {
        console.log("Error creating or updating table in database: " + err)
        }

}
}
