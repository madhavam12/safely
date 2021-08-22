const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().functions);

var newData;

exports.helpRequest = functions.firestore.document('requests/{id}').onCreate(async(snapshot, context) => {


    if (snapshot.empty) {
        console.log('No Devices');
        return;
    }


    //device tokens
    const tokens = snapshot.data().deviceTokensNearby;

    var payload = {
        //payload below
        notification: {
            priority: "high",

            title: 'Someone needs help!',
            body: 'Tap here to know more.',

        },
        data: {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",

        },
    };

    try {
        const response = await admin.messaging().sendToDevice(tokens, payload);
        console.log('Notification sent successfully');


    } catch (err) {
        console.log(err);
    }
});