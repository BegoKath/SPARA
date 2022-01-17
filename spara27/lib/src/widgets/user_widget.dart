import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/providers/user_provider.dart';

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
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
              child: Text(
                'Registrarse',
                style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un Email';
                }
                return null;
              },
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.alternate_email), hintText: 'Email'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline), hintText: 'Contraseña'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            IconButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _signUpUser(_emailController.text, _passwordController.text,
                        context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ingrese los campos')),
                    );
                  }
                },
                icon: const Icon(Icons.save))
          ],
        ));
  }

  void _signUpUser(String email, String password, BuildContext context) async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: true);

    try {
      if (await _userProvider.signUpUser(email, password)) {
        var uid = _userProvider.getUid;
        Navigator.pop(context);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
