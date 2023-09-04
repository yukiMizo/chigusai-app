const functions = require("firebase-functions");

const admin = require("firebase-admin");
admin.initializeApp();

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
exports.sendNotification = functions.firestore.
    document("notification/{docId}").
    onCreate((snap, context) => {
      const newValue = snap.data();
      admin.messaging().sendToTopic("notification", {
        notification: {
          title: newValue["title"],
          body: newValue["content"],
        },
      });
      return 0;
    });
