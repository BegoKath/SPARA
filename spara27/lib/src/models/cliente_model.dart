import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario(
      {this.apellido,
      this.edad,
      this.email,
      this.nombre,
      this.uid,
      this.urlImage,
      this.idD});

  String? apellido;
  String? edad;
  String? email;
  String? nombre;
  String? uid;
  String? urlImage;
  String? idD;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        apellido: json["apellido"],
        edad: json["edad"],
        email: json["email"],
        nombre: json["nombre"],
        uid: json["uid"],
        urlImage: json["urlImage"],
      );

  Map<String, dynamic> toJson() => {
        "apellido": apellido,
        "edad": edad,
        "email": email,
        "nombre": nombre,
        "uid": uid,
        "urlImage": urlImage,
      };
}
