import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spara27/src/models/cliente_model.dart';
import 'package:spara27/src/pages/login_page.dart';
import 'package:spara27/src/pages/map_page.dart';
import 'package:spara27/src/pages/updateperfil_page.dart';
import 'package:spara27/src/providers/main_provider.dart';
import 'package:spara27/src/services/cliente_service.dart';

class SettingsWisget extends StatefulWidget {
  const SettingsWisget({Key? key}) : super(key: key);

  @override
  State<SettingsWisget> createState() => _SettingsWisgetState();
}

class _SettingsWisgetState extends State<SettingsWisget> {
  final ClienteService _clienteService = ClienteService();

  late Usuario usuario;
  @override
  void initState() {
    super.initState();
    usuario = Usuario.created();
    cargaDatos(context);
  }

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    if (usuario.nombre!.isEmpty) {
      return const Center(
          child: SizedBox(
              height: 50.0,
              width: 50.0,
              child: CircularProgressIndicator(color: Colors.white)));
    } else {
      return ListView(children: [
        const SizedBox(
          height: 20,
        ),
        CircleAvatar(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          radius: 120,
          child: ClipOval(
            child: usuario.urlImage!.isEmpty
                ? CircleAvatar(
                    backgroundColor: Colors.cyan,
                    radius: 120, // button color
                    child: InkWell(
                      splashColor: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.person_add_alt_1,
                              size: 40, color: Colors.white), // icon
                        ],
                      ),
                    ),
                  )
                : Image.network(
                    usuario.urlImage!,
                    width: 210,
                    height: 210,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Card(
            elevation: 0,
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                Text(usuario.nombre!,
                    style: GoogleFonts.robotoSlab(
                        color: Colors.white,
                        textStyle: Theme.of(context).textTheme.headline4)),
                Text(usuario.email!,
                    style: GoogleFonts.robotoSlab(
                        color: Colors.white,
                        textStyle: Theme.of(context).textTheme.bodyText1))
              ],
            )),
        Card(
          child: ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Actualizar Datos"),
            trailing: IconButton(
                tooltip: "Actualizar Datos",
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PerfilPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.update_outlined, color: Colors.orange)),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.light_mode),
            title: const Text("Modo Nocturno"),
            trailing: Switch(
                activeColor: Colors.orange,
                value: mainProvider.mode,
                onChanged: (bool value) async {
                  mainProvider.mode = value;
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool("mode", value);
                  setState(() {});
                }),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text("Ubicación"),
            trailing: IconButton(
                tooltip: "Ubicación",
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MapSample()),
                  );
                },
                icon:
                    const Icon(Icons.arrow_forward_ios, color: Colors.orange)),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Cerrar sesión"),
            trailing: IconButton(
                tooltip: "Cerrar sesión",
                onPressed: () {
                  mainProvider.token = "";
                  mainProvider.index = 0;
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.orange)),
          ),
        ),
      ]);
    }
  }

  cargaDatos(BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    var uid = mainProvider.token;
    usuario = await _clienteService.getUsuario(uid);
    if (mounted) {
      setState(() {});
    }
  }
}
