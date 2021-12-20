export interface Cliente {
    idCliente?:      string;
    usuario:         string;
    contraseña:      string;
    nombre:          string;
    apellido:        string;
    edad:            number;
    email:           string;
    fechaNacimiento: string;
    sexo:            string;
}
export function Cliente(data :any, id?:string){
    const { usuario, contraseña, nombre, apellido, edad, email, fechaNacimiento, sexo } = data;

    let object : Cliente = { 
    idCliente: id,
    usuario: usuario,
    contraseña: contraseña,
    nombre: nombre,
    apellido: apellido,
    edad: edad,
    email: email,
    fechaNacimiento:fechaNacimiento,
    sexo: sexo,
    };
    return object;
}