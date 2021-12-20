export interface Ahorro {
    idahorro?:   String;
    monto:       number;
    metaAhorro:  number;
    descripcion: string;
    fechaInicio: string;
    fechaFinal:  string;
}
export function Ahorro(data :any, id?:string){
    const { monto, metaAhorro, descripcion, fechaInicio, fechaFinal } = data;

    let object :Ahorro = { 
    idahorro: id,               
    monto:   monto,
    metaAhorro:  metaAhorro,
    descripcion:descripcion,
    fechaInicio: fechaInicio,
    fechaFinal:  fechaFinal,
    };
    return object;
}