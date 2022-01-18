import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/models/cliente_model.dart';
import 'package:spara27/src/providers/user_provider.dart';
import 'package:spara27/src/services/cliente_service.dart';
import 'package:spara27/src/services/imagen_service.dart';

class PerfilWidget extends StatefulWidget {
  const PerfilWidget({Key? key}) : super(key: key);

  @override
  State<PerfilWidget> createState() => _PerfilWidgetState();
}

class _PerfilWidgetState extends State<PerfilWidget> {
  final FotosService _fotosService = FotosService();
  final ClienteService _clienteService = ClienteService();

  Usuario? usuario =
      Usuario(nombre: "", apellido: "", edad: "", uid: "", urlImage: "");
  File? image;
  String urlImagen = "";

  @override
  void initState() {
    super.initState();
    _downloadUsuario();
  }

  _downloadUsuario() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    var uid = _userProvider.getUid;
    usuario = await _clienteService.getUsuario(uid!);
    _userProvider.setNombre = usuario!.nombre!;
    _userProvider.setUser(usuario!);
    urlImagen = usuario!.urlImage!;
    if (mounted) {
      setState(() {});
    }
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
    final UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final _formKey = GlobalKey<FormState>();

    var _nameController = TextEditingController(text: usuario!.nombre);
    var _lastnameController = TextEditingController(text: usuario!.apellido);
    var _ageController = TextEditingController(text: usuario!.edad);

    return usuario == null
        ? const Center(
            child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(color: Colors.white)))
        : Center(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 40.0)),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              side: MaterialStateProperty.all(
                                BorderSide.lerp(
                                    const BorderSide(
                                        width: 2.0, color: Colors.black),
                                    const BorderSide(
                                        width: 2.0, color: Colors.black),
                                    10.0),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Usuario user = Usuario(
                                    nombre: _nameController.text,
                                    uid: _userProvider.getUid,
                                    apellido: _lastnameController.text,
                                    email: _userProvider.getEmail,
                                    edad: _ageController.text,
                                    urlImage: urlImagen,
                                    idD: usuario!.idD);
                                _clienteService.updateToServer(user);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Ingrese los campos')),
                                );
                              }
                            },
                            child: Text(
                              "Actualizar",
                              style: GoogleFonts.robotoSlab(
                                  color: Colors.white,
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle1),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 8.0),
                        child: Text(
                          'Perfil',
                          style: GoogleFonts.robotoSlab(
                              fontSize: 25,
                              textStyle: Theme.of(context).textTheme.subtitle1),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.person_add_alt_1,
                                            size: 40,
                                            color: Colors.white), // icon
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
                            textStyle: Theme.of(context).textTheme.subtitle1),
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese un Nombre';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_outline,
                                color: Colors.cyan),
                            hintText: 'Nombre',
                            hintStyle: GoogleFonts.robotoSlab(
                                color: Theme.of(context).primaryColorDark,
                                textStyle:
                                    Theme.of(context).textTheme.subtitle1)),
                      ),
                      TextFormField(
                        style: GoogleFonts.robotoSlab(
                            textStyle: Theme.of(context).textTheme.subtitle1),
                        controller: _lastnameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese un Apellido';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_outline,
                                color: Colors.cyan),
                            hintText: 'Apellido',
                            hintStyle: GoogleFonts.robotoSlab(
                                color: Theme.of(context).primaryColorDark,
                                textStyle:
                                    Theme.of(context).textTheme.subtitle1)),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.robotoSlab(
                            textStyle: Theme.of(context).textTheme.subtitle1),
                        controller: _ageController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese la Edad';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.child_care_outlined,
                                color: Colors.cyan),
                            hintText: 'Edad',
                            hintStyle: GoogleFonts.robotoSlab(
                                color: Theme.of(context).primaryColorDark,
                                textStyle:
                                    Theme.of(context).textTheme.subtitle1)),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
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
