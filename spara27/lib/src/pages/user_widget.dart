import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/pages/user_form.dart';
import 'package:spara27/src/providers/main_provider.dart';
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
          height: 400,
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
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
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
                const SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  style: GoogleFonts.robotoSlab(
                      color: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context).textTheme.subtitle1),
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un Email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.alternate_email,
                        color: Colors.cyan,
                      ),
                      hintText: 'Email',
                      hintStyle: GoogleFonts.robotoSlab(
                          color: Theme.of(context).primaryColorDark,
                          textStyle: Theme.of(context).textTheme.subtitle1)),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: GoogleFonts.robotoSlab(
                      color: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context).textTheme.subtitle1),
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una contraseña';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.lock_outline, color: Colors.cyan),
                      hintText: 'Contraseña',
                      hintStyle: GoogleFonts.robotoSlab(
                          color: Theme.of(context).primaryColorDark,
                          textStyle: Theme.of(context).textTheme.subtitle1)),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                IconButton(
                    iconSize: 40.0,
                    alignment: Alignment.centerRight,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
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
    ));
  }

  void _signUpUser(String email, String password, BuildContext context) async {
    UserService _userService = UserService();

    try {
      final mainProvider = Provider.of<MainProvider>(context, listen: false);
      if (await _userService.signUpUser(email, password)) {
        var uid = _userService.getUid!;
        mainProvider.token = uid;
        mainProvider.email = email;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const UserForm(),
          ),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
