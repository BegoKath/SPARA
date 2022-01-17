import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String id = 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    color: Colors.yellow, //PARA PROBAR CONTAINER
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
                userTextField(),
                const SizedBox(
                  height: 10,
                ),
                passwordTextField(),
                const SizedBox(
                  height: 10,
                ),
                _buttonLogin()
              ],
            ))));
  }

  Widget userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.cyan,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            style: GoogleFonts.robotoSlab(
                color: Colors.white70,
                textStyle: Theme.of(context).textTheme.subtitle1),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: const Icon(Icons.email, color: Colors.white),
                labelStyle: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.subtitle1),
                labelText: 'Correo Electrónico'),
            onChanged: (value) {},
          ));
    });
  }

  Widget passwordTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.cyan,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            style: GoogleFonts.robotoSlab(
                color: Colors.white70,
                textStyle: Theme.of(context).textTheme.subtitle1),
            keyboardType: TextInputType.emailAddress,
            obscureText: true,
            decoration: InputDecoration(
                icon: const Icon(Icons.password, color: Colors.white),
                labelStyle: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.subtitle1),
                labelText: 'Contraseña'),
            onChanged: (value) {},
          ));
    });
  }

  Widget _buttonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shadowColor: MaterialStateProperty.all<Color>(Colors.cyan)),
        child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: const Text('Iniciar Sesión')),
      );
    });
  }
}
