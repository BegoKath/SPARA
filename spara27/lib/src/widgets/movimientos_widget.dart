import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:spara27/src/models/movimiento_model.dart';
import 'package:spara27/src/providers/main_provider.dart';
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
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 14.0),
        child: Column(
          children: [
            calendario(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Ultimos Movimientos",
                textAlign: TextAlign.justify,
                style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.headline6),
              ),
            ),
            listaMovimientosWidget(),
            const SizedBox(
              height: 45,
            )
          ],
        ));
  }

  Widget listaMovimientosWidget() {
    return _listaMovimientos == null
        ? const Center(
            child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(color: Colors.white)))
        : _listaMovimientos!.isEmpty
            ? Center(
                child: SizedBox(
                    child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Image.network(
                    "https://res.cloudinary.com/dvpl8qsgd/image/upload/v1643813878/SPARA/pngwing.com_gr0awq.png",
                    width: 120,
                    height: 120,
                  ),
                  Text("No tienes movimientos",
                      style: GoogleFonts.robotoSlab(
                          color: Colors.cyan.shade400,
                          textStyle: Theme.of(context).textTheme.bodyText2)),
                  Text("Agregue sus movimientos usando el boton (+)",
                      style: GoogleFonts.robotoSlab(
                          fontSize: 10,
                          color: Colors.white,
                          textStyle: Theme.of(context).textTheme.bodyText2))
                ],
              )))
            : Expanded(
                child: ListView(
                  children: _listaMovimientos!
                      .map((e) => MovimientosCard(model: e))
                      .toList(),
                ),
              );
  }

  Widget calendario() {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: CalendarTimeline(
          initialDate: _selectedDate,
          firstDate: DateTime(2021),
          lastDate: DateTime.now().add(const Duration(days: 30)),
          onDateSelected: (date) {
            setState(() {
              _selectedDate = date!;
              _downloadMantenimientos();
            });
          },
          leftMargin: 10,
          dayColor: Colors.black,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Theme.of(context).primaryColorLight,
          dotsColor: Colors.white,
          locale: 'es',
        ));
  }

  _downloadMantenimientos() async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    _listaMovimientos = await _ahorroService.getMovimientos(
        mainProvider.token, _selectedDate.toIso8601String());
    if (mounted) {
      setState(() {});
    }
  }
}
