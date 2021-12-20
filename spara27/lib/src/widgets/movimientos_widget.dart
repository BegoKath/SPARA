import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spara27/src/models/movimiento_model.dart';
import 'package:spara27/src/widgets/movimientos_card.dart';

class MovimientosWidget extends StatefulWidget {
  const MovimientosWidget({Key? key}) : super(key: key);

  @override
  State<MovimientosWidget> createState() => _MovimientosWidgetState();
}

class _MovimientosWidgetState extends State<MovimientosWidget> {
  late DateTime _selectedDate;
  List<Movimiento>? _listaMovimientos;
  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 5));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
        color: Theme.of(context).primaryColor,
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  padding: EdgeInsets.all(15),
                  child: Text('Movimientos',
                      style: Theme.of(context).textTheme.headline6)),
            ]),
            Column(
              children: [
                /* Container(
                  color: Theme.of(context).primaryColorDark,
                  child: CalendarTimeline(
                    initialDate: _selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    onDateSelected: (date) {
                      setState(() {
                        _selectedDate = date!;
                      });
                    },
                    leftMargin: 10,
                    monthColor: Theme.of(context).primaryColorLight,
                    dayColor: Theme.of(context).primaryColorLight,
                    activeDayColor: Colors.white,
                    activeBackgroundDayColor:
                        Theme.of(context).primaryColorLight,
                    dotsColor: Colors.white,
                    selectableDayPredicate: (date) => date.day != 23,
                    locale: 'es',
                  ),
                ),*/
                _listaMovimientos == null
                    ? const Center(
                        child: SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: CircularProgressIndicator()))
                    : _listaMovimientos!.isEmpty
                        ? const Center(
                            child: SizedBox(
                                child: Text(
                                    "No Hay Infomacion en los Servidores")))
                        : Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 14.0),
                            child: ListView(
                              children: _listaMovimientos!
                                  .map((e) => MovimientosCard(model: e))
                                  .toList(),
                            )),
              ],
            ),
          ],
        ));
  }
}
