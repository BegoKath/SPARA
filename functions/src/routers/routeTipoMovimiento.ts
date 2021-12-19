import { Application } from "express";
import { listTipoMovimiento } from "../controllers/tipoMovimiento_controller";

export function routeTipoMovimiento (app: Application){
    app.get('/api/tipoMovimiento'), listTipoMovimiento;
}