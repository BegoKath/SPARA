import { Application } from "express";
import { listAhorro } from "../controllers/ahorro_controller"
import { listCliente } from "../controllers/cliente_controller";

export function routeAhorro (app: Application){
    app.get('/api/ahorro', listAhorro);
    app.get('/api/cliente'), listCliente;
}




   

