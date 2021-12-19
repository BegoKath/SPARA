import { Application } from "express";
import { listMovimiento } from "../controllers/movimiento_controller";

export function routeMovimiento (app: Application){
    app.get('/api/movimiento'), listMovimiento;
}