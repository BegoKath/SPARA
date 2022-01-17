import 'package:flutter/material.dart';

import 'package:spara27/src/models/ahorro_model.dart';
import 'package:spara27/src/services/ahorro_service.dart';
import 'package:spara27/src/widgets/ahorro_card.dart';

class AhorroWidget extends StatefulWidget {
  const AhorroWidget({Key? key}) : super(key: key);

  @override
  State<AhorroWidget> createState() => _AhorroWidgetState();
}

class _AhorroWidgetState extends State<AhorroWidget> {
  final AhorrosService _ahorroService = AhorrosService();

  List<Ahorro>? _listaAhorros;
  @override
  void initState() {
    super.initState();
    _downloadMantenimientos();
  }

  @override
  Widget build(BuildContext context) {
    return _listaAhorros == null
        ? const Center(
            child: SizedBox(
                height: 50.0, width: 50.0, child: CircularProgressIndicator()))
        : _listaAhorros!.isEmpty
            ? const Center(
                child: SizedBox(
                    child: Text("No Hay Infomacion en los Servidores")))
            : Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 14.0),
                child: ListView(
                  children:
                      _listaAhorros!.map((e) => AhorroCard(model: e)).toList(),
                ));
  }

  _downloadMantenimientos() async {
    _listaAhorros = await _ahorroService.getAhorros();
    if (mounted) {
      setState(() {});
    }
  }
}
