import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

import 'package:spara27/src/models/movimiento_model.dart';
import 'package:spara27/src/services/movimiento_service.dart';
import 'package:spara27/src/widgets/movimientos_card.dart';

class MovimientosWidget extends StatefulWidget {
  const MovimientosWidget({Key? key}) : super(key: key);

  @override
  State<MovimientosWidget> createState() => _MovimientosWidgetState();
}

class _MovimientosWidgetState extends State<MovimientosWidget> {
  late DateTime _selectedDate;
  final MovimientoService _ahorroService = MovimientoService();
  List<Movimiento>? _listaMovimientos;
  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
    _downloadMantenimientos();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 5));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return _listaMovimientos == null
        ? const Center(
            child: SizedBox(
                height: 50.0, width: 50.0, child: CircularProgressIndicator()))
        : _listaMovimientos!.isEmpty
            ? const Center(
                child: SizedBox(
                    child: Text("No Hay Infomacion en los Servidores")))
            : Container(
                margin: EdgeInsets.symmetric(vertical: 25.0, horizontal: 14.0),
                child: ListView(
                  children: _listaMovimientos!
                      .map((e) => MovimientosCard(model: e))
                      .toList(),
                ));
  }

  _downloadMantenimientos() async {
    _listaMovimientos = await _ahorroService.getAhorros();
    if (mounted) {
      setState(() {});
    }
  }
}
