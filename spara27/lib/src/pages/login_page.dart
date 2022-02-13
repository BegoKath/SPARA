import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/bloc/validator_bloc.dart';
import 'package:spara27/src/pages/home_page.dart';
import 'package:spara27/src/pages/user_widget.dart';
import 'package:spara27/src/providers/main_provider.dart';
import 'package:spara27/src/services/user_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String id = 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Validator validator = Validator();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Center(
                child: Column(
              children: [
                Flexible(
                    child: Container(
                  height: 400.0,
                  width: 600.0,
                  decoration: BoxDecoration(
                    color: Colors.black12, //PARA PROBAR CONTAINER
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://res.cloudinary.com/dvpl8qsgd/image/upload/v1642373805/SPARA/login_iifeme.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
                const SizedBox(
                  height: 10,
                ),
                Form(
                    key: _formKey,
                    child: Column(children: [
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white60,
                              width: 2,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: _emailController,
                            validator: validator.emailValidation,
                            style: GoogleFonts.robotoSlab(
                                color: Colors.white70,
                                textStyle:
                                    Theme.of(context).textTheme.subtitle1),
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                icon: const Icon(Icons.email,
                                    color: Colors.white),
                                labelStyle: GoogleFonts.robotoSlab(
                                    color: Colors.white,
                                    textStyle:
                                        Theme.of(context).textTheme.subtitle1),
                                labelText: 'Correo Electrónico'),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white60,
                              width: 2,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: validator.passwordValidation,
                            style: GoogleFonts.robotoSlab(
                                color: Colors.white70,
                                textStyle:
                                    Theme.of(context).textTheme.subtitle1),
                            keyboardType: TextInputType.emailAddress,
                            obscureText: true,
                            decoration: InputDecoration(
                                icon: const Icon(Icons.lock_outlined,
                                    color: Colors.white),
                                labelStyle: GoogleFonts.robotoSlab(
                                    color: Colors.white,
                                    textStyle:
                                        Theme.of(context).textTheme.subtitle1),
                                labelText: 'Contraseña'),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _loginUser(_emailController.text,
                                _passwordController.text, context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Ingrese los campos')),
                            );
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shadowColor:
                                MaterialStateProperty.all<Color>(Colors.cyan)),
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80.0, vertical: 15.0),
                            child: const Text('Iniciar Sesión')),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'No tienes cuenta? ',
                            style: GoogleFonts.robotoSlab(
                                fontSize: 12.0,
                                color: Colors.white,
                                textStyle:
                                    Theme.of(context).textTheme.subtitle1),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const UserWidget(),
                                  ),
                                );
                              },
                              child: Text(
                                'Registrate',
                                style: GoogleFonts.robotoSlab(
                                    color: Colors.cyan,
                                    textStyle:
                                        Theme.of(context).textTheme.subtitle1),
                              ))
                        ],
                      )
                    ]))
              ],
            ))));
  }

  void _loginUser(String email, String password, BuildContext context) async {
    UserService _userService = UserService();

    try {
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      var res = await _userService.loginUser(email, password);
      final scaffold = ScaffoldMessenger.of(context);
      if (res.isEmpty) {
        var uid = _userService.getUid!;
        mainProvider.token = uid;
        mainProvider.email = email;
        setState(() {});
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else if (res == "invalid-email") {
        scaffold.showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text('El email es invalido vuelva a ingresar.',
                style: GoogleFonts.robotoSlab(
                    fontSize: 12.0,
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.subtitle1)),
            action: SnackBarAction(
                label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
          ),
        );
      } else if (res == "user-disabled") {
        scaffold.showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text('El usuario a sido deshabilitado.',
                style: GoogleFonts.robotoSlab(
                    fontSize: 12.0,
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.subtitle1)),
            action: SnackBarAction(
                label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
          ),
        );
      } else if (res == "user-not-found") {
        scaffold.showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text('Email no registrado, Vuelva a ingresar.',
                style: GoogleFonts.robotoSlab(
                    fontSize: 12.0,
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.subtitle1)),
            action: SnackBarAction(
                label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
          ),
        );
      } else if (res == "wrong-password") {
        scaffold.showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text('Contraseña incorrecta vuelva a ingresar',
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
}
