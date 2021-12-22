import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.idCliente,
    this.usuario,
    this.contrasea,
    this.nombre,
    this.apellido,
    this.edad,
    this.email,
    this.fechaNacimiento,
    this.sexo,
  });

  String? idCliente;
  String? usuario;
  String? contrasea;
  String? nombre;
  String? apellido;
  String? edad;
  String? email;
  String? fechaNacimiento;
  String? sexo;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idCliente: json["idCliente"],
        usuario: json["usuario"],
        contrasea: json["contraseña"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        edad: json["edad"],
        email: json["email"],
        fechaNacimiento: json["fechaNacimiento"],
        sexo: json["sexo"],
      );

  Map<String, dynamic> toJson() => {
        "idCliente": idCliente,
        "usuario": usuario,
        "contraseña": contrasea,
        "nombre": nombre,
        "apellido": apellido,
        "edad": edad,
        "email": email,
        "fechaNacimiento": fechaNacimiento,
        "sexo": sexo,
      };
}
