import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
  Cliente({
    this.id,
    this.usuario,
    this.contrasea,
    this.nombre,
    this.apellido,
    this.edad,
    this.email,
    this.fechaNacimiento,
    this.sexo,
  });

  int? id;
  String? usuario;
  String? contrasea;
  String? nombre;
  String? apellido;
  String? edad;
  String? email;
  DateTime? fechaNacimiento;
  String? sexo;

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json["Id"],
        usuario: json["usuario"],
        contrasea: json["contrasea"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        edad: json["edad"],
        email: json["email"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        sexo: json["sexo"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "usuario": usuario,
        "contrasea": contrasea,
        "nombre": nombre,
        "apellido": apellido,
        "edad": edad,
        "email": email,
        "fecha_nacimiento": fechaNacimiento!.toIso8601String(),
        "sexo": sexo,
      };
}
