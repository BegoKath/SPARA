import { Application } from "express";
import { listCliente } from "../controllers/cliente_controller";

export function routeCliente (app: Application){
    app.get('/api/cliente'), listCliente;
}