import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/models/cuenta_model.dart';
import 'package:spara27/src/models/movimiento_model.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:spara27/src/pages/home_page.dart';
import 'package:spara27/src/providers/main_provider.dart';
import 'package:spara27/src/services/cuenta_service.dart';
import 'package:spara27/src/services/movimiento_service.dart';
import 'package:spara27/src/utils/main_menu.dart';

class MovimientoPage extends StatefulWidget {
  const MovimientoPage({Key? key, required this.tipo}) : super(key: key);
  final bool tipo;
  @override
  State<MovimientoPage> createState() => _MovimientoPageState();
}

class _MovimientoPageState extends State<MovimientoPage> {
  final _formKey = GlobalKey<FormState>();
  late Movimiento movimiento;
  var _typeSelected = categorias[0];
  final MovimientoService _movimientoService = MovimientoService();
  final CuentaService _cuentaService = CuentaService();
  @override
  void initState() {
    super.initState();
    movimiento = Movimiento.created();
    initializeDateFormatting("es_ES");
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    DateFormat dateFormat = DateFormat("yyyy-MMMM-dd", "ES");
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: widget.tipo
            ? Text("\t Agregar Ingreso",
                style: GoogleFonts.lora(
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.headline5))
            : Text("\t Agregar Egreso",
                style: GoogleFonts.lora(
                    color: Colors.white,
                    textStyle: Theme.of(context).textTheme.headline5)),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            )),
        width: size.width,
        height: size.height,
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 8.0),
                    child: Text(
                      'Movimiento',
                      style: GoogleFonts.robotoSlab(
                          textStyle: Theme.of(context).textTheme.headline5),
                    ),
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    initialValue: movimiento.monto.toString(),
                    style: GoogleFonts.robotoSlab(
                        fontSize: 45,
                        textStyle: Theme.of(context).textTheme.subtitle1),
                    onSaved: (value) {
                      movimiento.monto = double.parse(value.toString());
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty || value == "0.0") {
                        return 'Debe ser mayor a 0';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.monetization_on,
                            color: Colors.cyan),
                        labelText: 'Valor',
                        labelStyle: GoogleFonts.robotoSlab(
                            textStyle: Theme.of(context).textTheme.bodyText1)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    initialValue: movimiento.descripcion,
                    style: GoogleFonts.robotoSlab(
                        textStyle: Theme.of(context).textTheme.subtitle1),
                    onSaved: (value) {
                      movimiento.descripcion = value.toString();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese una descripción';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.description, color: Colors.cyan),
                        hintText: 'Descripción',
                        hintStyle: GoogleFonts.robotoSlab(
                            textStyle: Theme.of(context).textTheme.bodyText1)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 13.0),
                            child: Text("Fecha",
                                style: GoogleFonts.robotoSlab(
                                    fontSize: 12,
                                    textStyle:
                                        Theme.of(context).textTheme.bodyText1)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 13),
                                child:
                                    Icon(Icons.date_range, color: Colors.cyan),
                              ),
                              Text(dateFormat.format(movimiento.fechaInicio!),
                                  style: GoogleFonts.robotoSlab(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .subtitle1)),
                            ],
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2018, 3, 5),
                                maxTime: DateTime(2026, 6, 7),
                                onChanged: (date) {
                              setState(() {
                                movimiento.fechaInicio = date;
                              });
                            }, onConfirm: (date) {
                              setState(() {
                                movimiento.fechaInicio = date;
                              });
                            },
                                currentTime: movimiento.fechaInicio,
                                locale: LocaleType.es);
                          },
                          child: Text("Cambiar",
                              style: GoogleFonts.robotoSlab(
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle1))),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: Text("Categoría",
                            style: GoogleFonts.robotoSlab(
                                fontSize: 12,
                                textStyle:
                                    Theme.of(context).textTheme.bodyText1)),
                      ),
                      DropdownButton<Categoria>(
                        value: _typeSelected,
                        icon: const Icon(Icons.arrow_downward,
                            color: Colors.cyan),
                        elevation: 16,
                        style: GoogleFonts.robotoSlab(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 15.0,
                            textStyle: Theme.of(context).textTheme.bodyText1),
                        underline: Container(height: 2),
                        onChanged: (Categoria? newValue) {
                          movimiento.categoria = categorias.indexOf(newValue!);
                          setState(() {
                            _typeSelected = newValue;
                          });
                        },
                        items: categorias.map<DropdownMenuItem<Categoria>>(
                            (Categoria value) {
                          return DropdownMenuItem<Categoria>(
                            value: value,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13),
                                  child: Icon(
                                    value.icon,
                                    color: value.color,
                                  ),
                                ),
                                Text(value.nombre,
                                    style: GoogleFonts.robotoSlab(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .subtitle1)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return Theme.of(context).secondaryHeaderColor;
                            },
                          ),
                        ),
                        label: Text('Agregar',
                            style: GoogleFonts.robotoSlab(
                                fontSize: 18,
                                color: widget.tipo ? Colors.green : Colors.red,
                                textStyle:
                                    Theme.of(context).textTheme.bodyText1)),
                        icon: Icon(Icons.add_box,
                            color: widget.tipo
                                ? Colors.greenAccent
                                : Colors.redAccent),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            movimiento = Movimiento(
                                uid: mainProvider.token,
                                descripcion: movimiento.descripcion,
                                monto: movimiento.monto,
                                fechaInicio: movimiento.fechaInicio,
                                categoria: movimiento.categoria,
                                tipoMovimiento:
                                    widget.tipo ? "Ingreso" : "Egreso");
                            _movimientoService.sendToServer(movimiento);
                            saldosCuenta(mainProvider.token);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Ingrese los campos')),
                            );
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  saldosCuenta(String uid) async {
    Cuenta cuenta = await _cuentaService.getCuenta(uid);
    cuenta.saldo = widget.tipo
        ? (cuenta.saldo! + movimiento.monto!)
        : (cuenta.saldo! - movimiento.monto!);
    _cuentaService.updateToServer(cuenta);
  }
}
