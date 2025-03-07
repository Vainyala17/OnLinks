const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendNewQuestionNotification = functions.firestore
    .document("questions/{questionId}")
    .onCreate(async (snap, context) => {
        const questionData = snap.data();
        const formName = questionData.formName;

        const payload = {
            notification: {
                title: "New Question Alert!",
                body: `Someone asked a question about ${formName}. Join the discussion now!`,
            },
        };

        const allTokens = await getAllUserTokens();
        if (allTokens.length > 0) {
            await admin.messaging().sendToDevice(allTokens, payload);
            console.log("Notification sent successfully!");
        } else {
            console.log("No users have subscribed for notifications.");
        }
    });

async function getAllUserTokens() {
    const tokensSnapshot = await admin.firestore().collection("userTokens").get();
    return tokensSnapshot.docs.map(doc => doc.data().token);
}
