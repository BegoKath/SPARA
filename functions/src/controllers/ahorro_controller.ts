import { Request, Response } from "express";
import { Ahorro } from "../models/ahorro-model";
import { db } from "../index";

export async function listAhorro(req: Request, res: Response) {           
    try{                    
        let snapshot = await db.collection("ahorro").get();
        return res.status(200).json(snapshot.docs.map(doc => Ahorro(doc.data(), doc.id)));
    }
    catch(err){
        return handleError(res, err);
    }
}

function handleError(res: Response, err: any) {
    return res.status(500).send({ message: `${err.code} - ${err.message}` });
}