import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/models/cliente_model.dart';
import 'package:spara27/src/pages/login_page.dart';
import 'package:spara27/src/providers/user_provider.dart';
import 'package:spara27/src/services/cliente_service.dart';
import 'package:spara27/src/services/imagen_service.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final FotosService _fotosService = FotosService();
  File? image;
  String urlImagen = "";
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
        Provider.of<UserProvider>(context, listen: true);
    final _formKey = GlobalKey<FormState>();
    final ClienteService _clienteService = ClienteService();
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
                height: 500,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 40.0)),
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
                                      urlImage: urlImagen);
                                  _clienteService.sendToServer(user);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Ingrese los campos')),
                                  );
                                }
                              },
                              child: Text(
                                "Registrar",
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
                              color: Theme.of(context).primaryColor,
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
                              color: Theme.of(context).primaryColor,
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
            )));
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
