import { Application } from "express";
import { listCuenta } from "../controllers/cuenta_controller";

export function routeCuenta (app: Application){
    app.get('/api/cuenta'), listCuenta;
}