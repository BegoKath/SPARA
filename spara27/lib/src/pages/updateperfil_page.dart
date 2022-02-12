import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/models/cliente_model.dart';
import 'package:spara27/src/providers/main_provider.dart';
import 'package:spara27/src/services/cliente_service.dart';
import 'package:spara27/src/services/imagen_service.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final FotosService _fotosService = FotosService();
  final ClienteService _clienteService = ClienteService();

  late Usuario usuario;
  File? image;

  @override
  void initState() {
    super.initState();
    usuario = Usuario.created();
    cargaDatos(context);
  }

  Future _selectImage(ImageSource source) async {
    try {
      final imageCamera = await ImagePicker().pickImage(source: source);
      if (imageCamera == null) return;
      final imageTemporary = File(imageCamera.path);
      image = imageTemporary;
      if (image != null) {
        usuario.urlImage = await _fotosService.uploadImage(image!);
      }
    } on Exception {
      // print('Fallo al escoger una imagen: $e');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
            body: usuario.nombre!.isEmpty
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
                                          const EdgeInsets.symmetric(
                                              horizontal: 40.0)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Theme.of(context).primaryColor),
                                      side: MaterialStateProperty.all(
                                        BorderSide.lerp(
                                            const BorderSide(
                                                width: 2.0,
                                                color: Colors.black),
                                            const BorderSide(
                                                width: 2.0,
                                                color: Colors.black),
                                            10.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        Usuario user = Usuario(
                                            nombre: usuario.nombre,
                                            uid: usuario.uid,
                                            apellido: usuario.apellido,
                                            email: usuario.email,
                                            edad: usuario.edad,
                                            urlImage: usuario.urlImage,
                                            idD: usuario.idD);
                                        _clienteService.updateToServer(user);
                                        Navigator.pop(context);
                                        setState(() {});
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Ingrese los campos')),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Actualizar",
                                      style: GoogleFonts.robotoSlab(
                                          color: Colors.white,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .subtitle1),
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
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ),
                              ),
                              SizedBox.fromSize(
                                size: const Size(
                                    150, 150), // button width and height
                                child: ClipOval(
                                  child: usuario.urlImage!.isEmpty
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
                                                    color:
                                                        Colors.white), // icon
                                              ],
                                            ),
                                          ),
                                        )
                                      : Image(
                                          image:
                                              NetworkImage(usuario.urlImage!)),
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
                                initialValue: usuario.nombre,
                                style: GoogleFonts.robotoSlab(
                                    color: Theme.of(context).primaryColorDark,
                                    textStyle:
                                        Theme.of(context).textTheme.subtitle1),
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
                                    hintText: 'Nombre',
                                    hintStyle: GoogleFonts.robotoSlab(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle1)),
                              ),
                              TextFormField(
                                initialValue: usuario.apellido,
                                style: GoogleFonts.robotoSlab(
                                    color: Theme.of(context).primaryColorDark,
                                    textStyle:
                                        Theme.of(context).textTheme.subtitle1),
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
                                    hintText: 'Apellido',
                                    hintStyle: GoogleFonts.robotoSlab(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle1)),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                initialValue: usuario.edad,
                                style: GoogleFonts.robotoSlab(
                                    color: Theme.of(context).primaryColorDark,
                                    textStyle:
                                        Theme.of(context).textTheme.subtitle1),
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
                                    prefixIcon: const Icon(
                                        Icons.child_care_outlined,
                                        color: Colors.cyan),
                                    hintText: 'Edad',
                                    hintStyle: GoogleFonts.robotoSlab(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle1)),
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

  cargaDatos(BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    var uid = mainProvider.token;
    usuario = await _clienteService.getUsuario(uid);
    if (mounted) {
      setState(() {});
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
