import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:spara27/src/models/ahorro_model.dart';
import 'package:spara27/src/models/cuenta_model.dart';
import 'package:spara27/src/pages/listaahorro_page.dart';
import 'package:spara27/src/providers/main_provider.dart';
import 'package:spara27/src/services/ahorro_service.dart';
import 'package:spara27/src/services/cuenta_service.dart';
import 'package:fl_chart/fl_chart.dart';

class AhorroWidget extends StatefulWidget {
  const AhorroWidget({Key? key}) : super(key: key);

  @override
  State<AhorroWidget> createState() => _AhorroWidgetState();
}

class _AhorroWidgetState extends State<AhorroWidget> {
  final _formKey = GlobalKey<FormState>();
  final Color barBackgroundColor = Colors.grey.shade300;
  final Duration animDuration = const Duration(milliseconds: 250);
  //meses
  final monthName1 = DateFormat.MMMM('ES').format(DateTime.now());
  final monthName2 = DateFormat.MMMM('ES')
      .format(DateTime.now().subtract(const Duration(days: 31)));
  final monthName3 = DateFormat.MMMM('ES')
      .format(DateTime.now().subtract(const Duration(days: 61)));
  int touchedIndex = -1;
  //cuenta
  late Cuenta cuenta;
  final CuentaService _cuentaService = CuentaService();
  //Ahorros
  final AhorrosService _ahorroService = AhorrosService();
  late DateTime _fechai;
  late DateTime _fechaf;
  List<Ahorro>? _listaAhorros1;
  List<Ahorro>? _listaAhorros2;
  List<Ahorro>? _listaAhorros3;
  var ahorro1 = 0.0;
  var ahorro2 = 0.0;
  var ahorro3 = 0.0;
  @override
  void initState() {
    super.initState();

    _resetSelectedDate();
    _downloadMantenimientos();

    cuenta = Cuenta.created();
    cargaDatos(context);

    initializeDateFormatting("es_ES");
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            "Ahorros",
            textAlign: TextAlign.center,
            style: GoogleFonts.lora(
                color: Colors.white,
                textStyle: Theme.of(context).textTheme.headline5),
          ),
        ),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                width: size.width - 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Theme.of(context).secondaryHeaderColor),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Meta:",
                        style: GoogleFonts.robotoSlab(
                            fontSize: 20.0,
                            color: Colors.orange,
                            textStyle: Theme.of(context).textTheme.headline5)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Icon(
                        Icons.attach_money,
                        size: 20.0,
                      ),
                      Text(cuenta.metaAhorro.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoSlab(
                              fontSize: 20.0,
                              textStyle:
                                  Theme.of(context).textTheme.headline5)),
                    ]),
                  ],
                ))),
          ],
        )),
        Flexible(
          child: AspectRatio(
            aspectRatio: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: Theme.of(context).secondaryHeaderColor,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BarChart(
                              mainBarData(),
                              swapAnimationDuration: animDuration,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AhorrosPage(
                                          modelos: _listaAhorros3!,
                                          mes: monthName3),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.list,
                                    color: Colors.orange)),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AhorrosPage(
                                          modelos: _listaAhorros2!,
                                          mes: monthName2),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.list,
                                    color: Colors.orange)),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AhorrosPage(
                                          modelos: _listaAhorros1!,
                                          mes: monthName1),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.list,
                                    color: Colors.orange))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue:
                    cuenta.metaAhorro != 0 ? cuenta.metaAhorro.toString() : "",
                style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontSize: 25,
                    textStyle: Theme.of(context).textTheme.subtitle1),
                onSaved: (value) {
                  cuenta.metaAhorro = double.parse(value.toString());
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese una meta de ahorro';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _cuentaService.updateToServer(cuenta);
                          setState(() {});
                        }
                      },
                      icon: const Icon(
                        Icons.update,
                        color: Colors.orange,
                      ),
                    ),
                    prefixIcon: const Icon(Icons.star, color: Colors.cyan),
                    hintText: 'Cambiar la Meta de Ahorro',
                    hintStyle: GoogleFonts.robotoSlab(
                        color: Colors.orange,
                        fontSize: 15,
                        textStyle: Theme.of(context).textTheme.subtitle1)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    double width = 25,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.cyan] : [Theme.of(context).primaryColor],
          width: width,
          borderSide: isTouched
              ? const BorderSide(color: Colors.cyan, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: cuenta.metaAhorro,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(3, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, ahorro3, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, ahorro2, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, ahorro1, isTouched: i == touchedIndex);

          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.white,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                (rod.y - 1).toString(),
                const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return monthName3.toUpperCase();
              case 1:
                return monthName2.toUpperCase();
              case 2:
                return monthName1.toUpperCase();
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
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

  cargaDatos(BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    var uid = mainProvider.token;
    cuenta = await _cuentaService.getCuenta(uid);
    setState(() {});
    if (mounted) {
      setState(() {});
    }
  }

  _downloadMantenimientos() async {
    ahorro1 = 0;
    ahorro2 = 0;
    ahorro3 = 0;
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    DateTime _fechai2 = _fechai.subtract(const Duration(days: 31));
    DateTime _fechai3 = _fechai2.subtract(const Duration(days: 30));
    _listaAhorros1 = await _ahorroService.getMovimientos(mainProvider.token,
        _fechai.toIso8601String(), _fechaf.toIso8601String());
    _listaAhorros2 = await _ahorroService.getMovimientos(mainProvider.token,
        _fechai2.toIso8601String(), _fechai.toIso8601String());
    _listaAhorros3 = await _ahorroService.getMovimientos(mainProvider.token,
        _fechai3.toIso8601String(), _fechai2.toIso8601String());
    for (var a in _listaAhorros1!) {
      ahorro1 = ahorro1 + a.monto!;
    }
    for (var a in _listaAhorros2!) {
      ahorro2 = ahorro2 + a.monto!;
    }
    for (var a in _listaAhorros3!) {
      ahorro3 = ahorro3 + a.monto!;
    }
    if (mounted) {
      setState(() {});
    }
  }
}
