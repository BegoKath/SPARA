import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/models/cliente_model.dart';
import 'package:spara27/src/models/cuenta_model.dart';
import 'package:spara27/src/providers/main_provider.dart';
import 'package:spara27/src/services/cliente_service.dart';
import 'package:spara27/src/services/cuenta_service.dart';

// ignore: must_be_immutable
class InicioWidget extends StatefulWidget {
  const InicioWidget({Key? key}) : super(key: key);
  @override
  State<InicioWidget> createState() => _InicioWidgetState();
}

class _InicioWidgetState extends State<InicioWidget> {
  final ClienteService _clienteService = ClienteService();
  final CuentaService _cuentaService = CuentaService();
  late Usuario user;
  late Cuenta cuenta;

  @override
  void initState() {
    super.initState();
    user = Usuario.created();
    cuenta = Cuenta.created();
    cargaDatos(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return user.nombre!.isEmpty
        ? const Center(
            child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(color: Colors.white)))
        : Container(
            color: Theme.of(context).primaryColor,
            width: size.width,
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: Text('Hola ' + user.nombre!,
                          style: GoogleFonts.robotoSlab(
                              color: Colors.white,
                              textStyle:
                                  Theme.of(context).textTheme.headline6))),
                ]),
                Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(20),
                        width: size.width - 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Theme.of(context).secondaryHeaderColor),
                        child: Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              const Icon(
                                Icons.attach_money,
                                size: 40.0,
                              ),
                              Text(cuenta.saldo.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.robotoSlab(
                                      fontSize: 40.0,
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .headline5)),
                            ]))),
                    const SizedBox(
                      height: 60,
                    ),
                    //const HomeCard(),
                  ],
                ))
              ],
            ),
          );
  }

  cargaDatos(BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    if (mainProvider.token.isNotEmpty) {
      var uid = mainProvider.token;
      user = await _clienteService.getUsuario(uid);
      cuenta = await _cuentaService.getCuenta(uid);
      if (mounted) {
        setState(() {});
      }
    } else {
      user = Usuario.created();
    }
  }
}
