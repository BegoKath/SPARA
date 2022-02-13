import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/bloc/validator_bloc.dart';
import 'package:spara27/src/models/cliente_model.dart';
import 'package:spara27/src/models/cuenta_model.dart';
import 'package:spara27/src/pages/login_page.dart';
import 'package:spara27/src/providers/main_provider.dart';
import 'package:spara27/src/services/cliente_service.dart';
import 'package:spara27/src/services/cuenta_service.dart';
import 'package:spara27/src/services/imagen_service.dart';
import 'package:spara27/src/services/user_service.dart';

class UserWidget extends StatefulWidget {
  const UserWidget({Key? key}) : super(key: key);

  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Usuario usuario;

  final FotosService _fotosService = FotosService();
  final ClienteService _clienteService = ClienteService();
  final CuentaService _cuentaService = CuentaService();
  Validator validator = Validator();

  File? image;
  String urlImagen = "";
  @override
  void initState() {
    super.initState();
    usuario = Usuario.created();
  }

  Future _selectImage(ImageSource source) async {
    try {
      final imageCamera = await ImagePicker().pickImage(source: source);
      if (imageCamera == null) return;
      final imageTemporary = File(imageCamera.path);
      image = imageTemporary;
      if (image != null) {
        urlImagen = await _fotosService.uploadImage(image!);
      }
    } on Exception {
      // print('Fallo al escoger una imagen: $e');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: Row(
        children: const [
          Image(
            image: NetworkImage(
                "https://res.cloudinary.com/dvpl8qsgd/image/upload/v1639900999/SPARA/Property_1_Default_iuphlt.png"),
            fit: BoxFit.contain,
            height: 50,
          ),
        ],
      )),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              )),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 8.0),
                    child: Text(
                      'Registrarse',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: const Size(150, 150), // button width and height
                    child: ClipOval(
                      child: urlImagen.isEmpty
                          ? Material(
                              color: Colors.cyan, // button color
                              child: InkWell(
                                splashColor: Colors.blue,
                                // splash color
                                // button pressed
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.person_add_alt_1,
                                        size: 40, color: Colors.white), // icon
                                  ],
                                ),
                              ),
                            )
                          : Image(image: NetworkImage(urlImagen)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          iconSize: 30,
                          onPressed: () {
                            opcionesCamara(context);
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.cyan,
                          ))
                    ],
                  ),
                  TextFormField(
                    style: GoogleFonts.robotoSlab(
                        color: Theme.of(context).primaryColor,
                        textStyle: Theme.of(context).textTheme.subtitle1),
                    controller: _emailController,
                    validator: validator.emailValidation,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.alternate_email,
                          color: Colors.cyan,
                        ),
                        labelText: 'Email',
                        labelStyle: GoogleFonts.robotoSlab(
                            color: Theme.of(context).primaryColorDark,
                            textStyle: Theme.of(context).textTheme.subtitle1)),
                  ),
                  TextFormField(
                    style: GoogleFonts.robotoSlab(
                        color: Theme.of(context).primaryColor,
                        textStyle: Theme.of(context).textTheme.subtitle1),
                    controller: _passwordController,
                    obscureText: true,
                    validator: validator.passwordValidation,
                    decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.lock_outline, color: Colors.cyan),
                        labelText: 'Contraseña',
                        labelStyle: GoogleFonts.robotoSlab(
                            color: Theme.of(context).primaryColorDark,
                            textStyle: Theme.of(context).textTheme.subtitle1)),
                  ),
                  TextFormField(
                    initialValue: usuario.nombre,
                    style: GoogleFonts.robotoSlab(
                        color: Theme.of(context).primaryColorDark,
                        textStyle: Theme.of(context).textTheme.subtitle1),
                    onSaved: (value) {
                      usuario.nombre = value.toString();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un Nombre';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outline,
                            color: Colors.cyan),
                        labelText: 'Nombre',
                        labelStyle: GoogleFonts.robotoSlab(
                            color: Theme.of(context).primaryColorDark,
                            textStyle: Theme.of(context).textTheme.subtitle1)),
                  ),
                  TextFormField(
                    initialValue: usuario.apellido,
                    style: GoogleFonts.robotoSlab(
                        color: Theme.of(context).primaryColorDark,
                        textStyle: Theme.of(context).textTheme.subtitle1),
                    onSaved: (value) {
                      usuario.apellido = value.toString();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un Apellido';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outline,
                            color: Colors.cyan),
                        labelText: 'Apellido',
                        labelStyle: GoogleFonts.robotoSlab(
                            color: Theme.of(context).primaryColorDark,
                            textStyle: Theme.of(context).textTheme.subtitle1)),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: usuario.edad,
                    style: GoogleFonts.robotoSlab(
                        color: Theme.of(context).primaryColorDark,
                        textStyle: Theme.of(context).textTheme.subtitle1),
                    onSaved: (value) {
                      usuario.edad = value.toString();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese la Edad';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.child_care_outlined,
                            color: Colors.cyan),
                        labelText: 'Edad',
                        labelStyle: GoogleFonts.robotoSlab(
                            color: Theme.of(context).primaryColorDark,
                            textStyle: Theme.of(context).textTheme.subtitle1)),
                  ),
                  IconButton(
                      iconSize: 40.0,
                      alignment: Alignment.centerRight,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _signUpUser(_emailController.text,
                              _passwordController.text, context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Ingrese los campos')),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_right_alt_outlined,
                        color: Colors.cyan,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  void _signUpUser(String email, String password, BuildContext context) async {
    UserService _userService = UserService();

    try {
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      var res = await _userService.signUpUser(email, password);
      final scaffold = ScaffoldMessenger.of(context);
      if (res.isEmpty) {
        var uid = _userService.getUid!;
        mainProvider.token = uid;
        mainProvider.email = email;
        usuario = Usuario(
            nombre: usuario.nombre,
            apellido: usuario.apellido,
            edad: usuario.edad,
            uid: uid,
            email: email,
            urlImage: urlImagen);
        _clienteService.sendToServer(usuario);
        Cuenta cuenta =
            Cuenta(uid: uid, saldo: 0, saldoAhorro: 0, metaAhorro: 0);
        _cuentaService.sendToServer(cuenta);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      } else if (res == "email-already-in-use") {
        scaffold.showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text('El email ya existe, pruebe iniciar sesión.',
                style: GoogleFonts.robotoSlab(
                    fontSize: 12.0,
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.subtitle1)),
            action: SnackBarAction(
                label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
          ),
        );
      } else if (res == "invalid-email") {
        scaffold.showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text('Ingrese un email valido.',
                style: GoogleFonts.robotoSlab(
                    fontSize: 12.0,
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.subtitle1)),
            action: SnackBarAction(
                label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
          ),
        );
      } else if (res == "operation-not-allowed") {
        scaffold.showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text('Esta operación es invalida.',
                style: GoogleFonts.robotoSlab(
                    fontSize: 12.0,
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.subtitle1)),
            action: SnackBarAction(
                label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
          ),
        );
      } else if (res == "weak-password") {
        scaffold.showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text('Contraseña es muy facil, ingrese otra por favor.',
                style: GoogleFonts.robotoSlab(
                    fontSize: 12.0,
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.subtitle1)),
            action: SnackBarAction(
                label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
          ),
        );
      } else {
        scaffold.showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(res,
                style: GoogleFonts.robotoSlab(
                    fontSize: 12.0,
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.subtitle1)),
            action: SnackBarAction(
                label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
          ),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  void opcionesCamara(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                        onTap: () async {
                          await _selectImage(ImageSource.camera);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Tomar una foto',
                                  style: GoogleFonts.robotoSlab(
                                      color: Theme.of(context).primaryColorDark,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ),
                              ),
                              const Icon(Icons.camera_alt_outlined,
                                  color: Colors.cyan)
                            ],
                          ),
                        )),
                    InkWell(
                        onTap: () async {
                          await _selectImage(ImageSource.gallery);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Seleccionar una foto',
                                  style: GoogleFonts.robotoSlab(
                                      color: Theme.of(context).primaryColorDark,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ),
                              ),
                              const Icon(Icons.image, color: Colors.cyan)
                            ],
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(color: Colors.red),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Cancelar',
                                  style: GoogleFonts.robotoSlab(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ));
        });
  }
}
