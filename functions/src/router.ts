import { Application } from "express";
import { listAhorro } from "./controllers/ahorro_controller"
import { listMovimiento } from "./controllers/movimiento_controller";
import { listCliente } from "./controllers/cliente_controller";
import { listCuenta } from "./controllers/cuenta_controller";
import { listTipoMovimiento } from "./controllers/tipoMovimiento_controller";

export function router (app: Application){
    app.get('/api/ahorro', listAhorro);
    app.get('/api/movimiento', listMovimiento);
    app.get('/api/cliente', listCliente);
    app.get('/api/cuenta', listCuenta);
    app.get('/api/tipoMovimiento', listTipoMovimiento);
}


   

