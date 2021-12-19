import * as functions from "firebase-functions";
import * as admin from 'firebase-admin';
import * as express from 'express';
import * as cors from 'cors';
import { routeAhorro } from "./routers/routeAhorro";
import { routeCliente } from "./routers/routeCliente";
import { routeCuenta } from "./routers/routeCuenta";
import { routeMovimiento } from "./routers/routeMovimiento";
import { routeTipoMovimiento } from "./routers/routeTipoMovimiento";

//============= SERVIDOR EXPRESS ================//
const server = express();
server.use(cors({origin: true}));

//============= FIREBASE CREDENCIALES ================//
admin.initializeApp(functions.config().firebase);

//============= FIREBASE BASE DE DATOS ================//
const db = admin.firestore(); //Base de datos de collections & documents
db.settings({ignoreUndefinedProperties : true, timestampsInSnapshot: true});

//============= RUTAS ================//
routeAhorro(server);
routeCliente(server);
routeCuenta(server);
routeMovimiento(server);
routeTipoMovimiento(server);


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
