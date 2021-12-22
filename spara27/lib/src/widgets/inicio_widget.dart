import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spara27/src/models/cliente_model.dart';
import 'package:spara27/src/services/cliente_service.dart';
import 'package:spara27/src/widgets/inicio_card.dart';

class InicioWidget extends StatefulWidget {
  const InicioWidget({Key? key}) : super(key: key);

  @override
  State<InicioWidget> createState() => _InicioWidgetState();
}

class _InicioWidgetState extends State<InicioWidget> {
  final ClienteService _clienteService = ClienteService();
  late Usuario _cliente;
  @override
  void initState() {
    super.initState();
    _downloadCliente();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return _cliente == null
        ? const Center(
            child: SizedBox(
                height: 50.0, width: 50.0, child: CircularProgressIndicator()))
        : Container(
            color: Theme.of(context).primaryColor,
            width: size.width,
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: Text('Hola ' + _cliente.nombre!,
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
                        height: 100,
                        padding: const EdgeInsets.all(20),
                        width: size.width - 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: Theme.of(context).secondaryHeaderColor),
                        child: Center(
                          child: Column(
                            children: [
                              Text("Saldo",
                                  style: GoogleFonts.robotoSlab(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText1)),
                              Text("1500",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.robotoSlab(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .headline5)),
                            ],
                          ),
                        )),
                    const HomeCard(),
                  ],
                ))
              ],
            ),
          );
  }

  _downloadCliente() async {
    _cliente = await _clienteService.getAhorros();
    if (mounted) {
      setState(() {});
    }
  }
}
