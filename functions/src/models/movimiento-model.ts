export interface Movimiento {
    idMovimiento?:   String;
    monto:          number;
    descripcion:    string;
    fechaInicio:    string;
    tipoMovimiento: string;
}
export function Movimiento(data :any, id?:string){
    const { monto, descripcion, fechaInicio, tipoMovimiento } = data;

    let object : Movimiento = { 
        idMovimiento: id,
        monto: monto,
        descripcion: descripcion,
        fechaInicio: fechaInicio,
        tipoMovimiento: tipoMovimiento,
    };
    return object;
}