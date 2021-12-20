import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
import * as express from 'express';
import * as cors from 'cors';
import { router } from "./router";

//============= SERVIDOR EXPRESS ================//
const server = express();
server.use(cors({origin: true}));

//============= FIREBASE CREDENCIALES ================//
admin.initializeApp(functions.config().firebase);

//============= FIREBASE BASE DE DATOS ================//
const db = admin.firestore(); //Base de datos de collections & documents
db.settings({ignoreUndefinedProperties : true, timestampsInSnapshot: true});

//============= RUTAS ================//
router(server);



//============= EXPORTACION DEL SERVIDOR ================//
export { db };
export const api = functions.https.onRequest(server);


// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
