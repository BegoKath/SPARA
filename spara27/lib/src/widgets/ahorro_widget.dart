import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:spara27/src/models/ahorro_model.dart';
import 'package:spara27/src/providers/main_provider.dart';
import 'package:spara27/src/services/ahorro_service.dart';
import 'package:spara27/src/widgets/ahorro_card.dart';

class AhorroWidget extends StatefulWidget {
  const AhorroWidget({Key? key}) : super(key: key);

  @override
  State<AhorroWidget> createState() => _AhorroWidgetState();
}

class _AhorroWidgetState extends State<AhorroWidget> {
  final AhorrosService _ahorroService = AhorrosService();
  late DateTime _fechai;
  late DateTime _fechaf;
  List<Ahorro>? _listaAhorros1;
  List<Ahorro>? _listaAhorros2;
  List<Ahorro>? _listaAhorros3;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
    _downloadMantenimientos();
    initializeDateFormatting("es_ES");
  }

  void _resetSelectedDate() {
    var month = DateTime.now().month;
    //primer mes
    if (month < 10) {
      _fechai =
          DateTime.parse("2022-0" + month.toString() + "-01T19:00:41.090750");
    } else {
      _fechai =
          DateTime.parse("2022-" + month.toString() + "-01T19:00:41.090750");
    }
    month = month + 1;
    if (month < 10) {
      _fechaf =
          DateTime.parse("2022-0" + month.toString() + "-01T19:00:41.090750");
    } else {
      _fechaf =
          DateTime.parse("2022-" + month.toString() + "-01T19:00:41.090750");
    }
  }

  @override
  Widget build(BuildContext context) {
    final monthName1 = DateFormat.MMMM('ES').format(_fechai);
    final monthName2 = DateFormat.MMMM('ES')
        .format(_fechai.subtract(const Duration(days: 31)));
    final monthName3 = DateFormat.MMMM('ES')
        .format(_fechai.subtract(const Duration(days: 61)));
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 14.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Metas de Ahorro ",
              textAlign: TextAlign.justify,
              style: GoogleFonts.lora(
                  color: Colors.white,
                  textStyle: Theme.of(context).textTheme.headline5),
            ),
          ),
          Text(monthName1.toUpperCase(),
              style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  textStyle: Theme.of(context).textTheme.bodyText1)),
          listaAhorro1Widget(),
          Text(monthName2.toUpperCase(),
              style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  textStyle: Theme.of(context).textTheme.bodyText1)),
          listaAhorro2Widget(),
          Text(monthName3.toUpperCase(),
              style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  textStyle: Theme.of(context).textTheme.bodyText1)),
          listaAhorro3Widget(),
        ]));
  }

  Widget listaAhorro1Widget() {
    return _listaAhorros1 == null
        ? const Center(
            child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(color: Colors.white)))
        : _listaAhorros1!.isEmpty
            ? Center(
                child: SizedBox(
                    child: Text("No tienes Ahorros",
                        style: GoogleFonts.robotoSlab(
                            color: Colors.cyan.shade400,
                            textStyle: Theme.of(context).textTheme.bodyText2))))
            : Expanded(
                child: ListView(
                children:
                    _listaAhorros1!.map((e) => AhorroCard(model: e)).toList(),
              ));
  }

  Widget listaAhorro2Widget() {
    return _listaAhorros2 == null
        ? const Center(
            child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(color: Colors.white)))
        : _listaAhorros2!.isEmpty
            ? Center(
                child: SizedBox(
                    child: Text("No tienes Ahorros",
                        style: GoogleFonts.robotoSlab(
                            color: Colors.cyan.shade400,
                            textStyle: Theme.of(context).textTheme.bodyText2))))
            : Expanded(
                child: ListView(
                children:
                    _listaAhorros2!.map((e) => AhorroCard(model: e)).toList(),
              ));
  }

  Widget listaAhorro3Widget() {
    return _listaAhorros3 == null
        ? const Center(
            child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(color: Colors.white)))
        : _listaAhorros3!.isEmpty
            ? Center(
                child: SizedBox(
                    child: Text("No tienes Ahorros",
                        style: GoogleFonts.robotoSlab(
                            color: Colors.cyan.shade400,
                            textStyle: Theme.of(context).textTheme.bodyText2))))
            : Expanded(
                child: ListView(
                children:
                    _listaAhorros3!.map((e) => AhorroCard(model: e)).toList(),
              ));
  }

  _downloadMantenimientos() async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    DateTime _fechai2 = _fechai.subtract(const Duration(days: 31));
    DateTime _fechai3 = _fechai2.subtract(const Duration(days: 30));
    _listaAhorros1 = await _ahorroService.getMovimientos(mainProvider.token,
        _fechai.toIso8601String(), _fechaf.toIso8601String());
    _listaAhorros2 = await _ahorroService.getMovimientos(mainProvider.token,
        _fechai2.toIso8601String(), _fechai.toIso8601String());
    _listaAhorros3 = await _ahorroService.getMovimientos(mainProvider.token,
        _fechai3.toIso8601String(), _fechai2.toIso8601String());
    if (mounted) {
      setState(() {});
    }
  }
}
