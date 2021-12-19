import { Request, Response } from "express";
import { db } from "../index";

export async function listMovimiento(req: Request, res: Response) {           
    try{                    
        let snapshot = await db.collection("movimiento").get();
        return res.status(200).json(snapshot.docs);
    }
    catch(err){
        return handleError(res, err);
    }
}

function handleError(res: Response, err: any) {
    return res.status(500).send({ message: `${err.code} - ${err.message}` });
}