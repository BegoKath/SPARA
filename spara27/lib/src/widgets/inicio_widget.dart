import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/models/cliente_model.dart';
import 'package:spara27/src/models/cuenta_model.dart';
import 'package:spara27/src/providers/main_provider.dart';
import 'package:spara27/src/services/cliente_service.dart';
import 'package:spara27/src/services/cuenta_service.dart';
import 'package:spara27/src/services/movimiento_service.dart';
import 'package:spara27/src/utils/main_menu.dart';

class InicioWidget extends StatefulWidget {
  const InicioWidget({Key? key}) : super(key: key);
  @override
  State<InicioWidget> createState() => _InicioWidgetState();
}

class _InicioWidgetState extends State<InicioWidget> {
  final ClienteService _clienteService = ClienteService();
  final CuentaService _cuentaService = CuentaService();

  final MovimientoService _movimientoService = MovimientoService();
  late Usuario user;
  late Cuenta cuenta;
  int touchedIndex = -1;
  List<Task> data = [];

  @override
  void initState() {
    user = Usuario.created();
    cuenta = Cuenta.created();
    cargaDatos(context);
    listaCategoria();
    super.initState();
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
                        padding: const EdgeInsets.all(10),
                        width: size.width - 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 5, color: Colors.cyan.shade900),
                            borderRadius: BorderRadius.circular(50.0),
                            color: Theme.of(context).secondaryHeaderColor),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Saldo",
                                style: GoogleFonts.robotoSlab(
                                    fontSize: 20.0,
                                    color: Colors.cyan,
                                    textStyle:
                                        Theme.of(context).textTheme.headline5)),
                            Row(
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
                                ]),
                          ],
                        ))),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.all(10),
                        width: size.width - 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            border: Border.all(
                                width: 5, color: Colors.cyan.shade900),
                            color: Theme.of(context).secondaryHeaderColor),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Ahorro",
                                style: GoogleFonts.robotoSlab(
                                    fontSize: 20.0,
                                    color: Colors.cyan,
                                    textStyle:
                                        Theme.of(context).textTheme.headline5)),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.attach_money,
                                    size: 40.0,
                                  ),
                                  Text(cuenta.saldoAhorro.toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.robotoSlab(
                                          fontSize: 40.0,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline5)),
                                ]),
                          ],
                        ))),
                  ],
                )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: size.width - 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Theme.of(context).secondaryHeaderColor),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Movimientos por Categoria",
                          style: GoogleFonts.robotoSlab(
                              fontSize: 20.0,
                              textStyle:
                                  Theme.of(context).textTheme.headline5)),
                    ),
                    data.isEmpty
                        ? const Center(
                            child: SizedBox(
                                height: 50.0,
                                width: 50.0,
                                child: CircularProgressIndicator(
                                    color: Colors.white)))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: data
                                    .map((e) => Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                shape: e.cantidad == 0
                                                    ? BoxShape.rectangle
                                                    : BoxShape.circle,
                                                color: e.color,
                                              ),
                                            ),
                                            Text(
                                              e.categoria,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black),
                                            )
                                          ],
                                        ))
                                    .toList(),
                              ),
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: PieChart(
                                    PieChartData(
                                        /*pieTouchData: PieTouchData(touchCallback:
                                          (FlTouchEvent event, pieTouchResponse) {
                                        setState(() {
                                          if (!event
                                                  .isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection ==
                                                  null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
                                        });
                                      }),*/
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 30,
                                        sections: showingSections()),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ]),
                )
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

  List<PieChartSectionData> showingSections() {
    return data.map((e) {
      return PieChartSectionData(
        color: e.color,
        value: double.parse(e.cantidad.toString()),
        radius: 60,
        title: e.cantidad.toString(),
        badgeWidget: Icon(e.icon),
        badgePositionPercentageOffset: 1.3,
        titleStyle: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff)),
      );
    }).toList();
  }

  listaCategoria() async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    for (var value in categorias) {
      int cantidad = await _movimientoService.getMovimientosCategoria(
          mainProvider.token, categorias.indexOf(value));
      Task task = Task(value.nombre, cantidad, value.color, value.icon);
      data.add(task);
    }
    if (mounted) {
      setState(() {});
    }
  }
}
