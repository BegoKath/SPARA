import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/models/ahorro_model.dart';
import 'package:spara27/src/models/cuenta_model.dart';
import 'package:spara27/src/pages/home_page.dart';
import 'package:spara27/src/providers/main_provider.dart';
import 'package:spara27/src/services/ahorro_service.dart';
import 'package:spara27/src/services/cuenta_service.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class AhorroFormPage extends StatefulWidget {
  const AhorroFormPage({Key? key}) : super(key: key);

  @override
  State<AhorroFormPage> createState() => _AhorroFormPageState();
}

class _AhorroFormPageState extends State<AhorroFormPage> {
  final _formKey = GlobalKey<FormState>();
  late Ahorro ahorro;
  final AhorrosService _movimientoService = AhorrosService();
  final CuentaService _cuentaService = CuentaService();
  @override
  void initState() {
    super.initState();
    ahorro = Ahorro.created();
    initializeDateFormatting("es_ES");
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MMMM-dd", "ES");
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              bottomOpacity: 0.0,
              elevation: 0.0,
              centerTitle: true,
              title: Text("Agregar Ahorro",
                  style: GoogleFonts.lora(
                      color: Colors.white,
                      textStyle: Theme.of(context).textTheme.headline5)),
            ),
            body: Center(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        )),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              initialValue: ahorro.monto.toString(),
                              style: GoogleFonts.robotoSlab(
                                  fontSize: 45,
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle1),
                              onSaved: (value) {
                                ahorro.monto = double.parse(value.toString());
                              },
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value == "0.0") {
                                  return 'Debe ser mayor a 0';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.monetization_on,
                                      color: Colors.cyan),
                                  labelText: 'Monto',
                                  labelStyle: GoogleFonts.robotoSlab(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText1)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: ahorro.descripcion,
                              style: GoogleFonts.robotoSlab(
                                  textStyle:
                                      Theme.of(context).textTheme.subtitle1),
                              onSaved: (value) {
                                ahorro.descripcion = value.toString();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ingrese una descripción';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.description,
                                      color: Colors.cyan),
                                  hintText: 'Descripción',
                                  hintStyle: GoogleFonts.robotoSlab(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText1)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 13.0),
                                      child: Text("Fecha",
                                          style: GoogleFonts.robotoSlab(
                                              fontSize: 12,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1)),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 13),
                                          child: Icon(Icons.date_range,
                                              color: Colors.cyan),
                                        ),
                                        Text(
                                            dateFormat
                                                .format(ahorro.fechaInicio!),
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
                                          ahorro.fechaInicio = date;
                                        });
                                      }, onConfirm: (date) {
                                        setState(() {
                                          ahorro.fechaInicio = date;
                                        });
                                      },
                                          currentTime: ahorro.fechaInicio,
                                          locale: LocaleType.es);
                                    },
                                    child: Text("Cambiar",
                                        style: GoogleFonts.robotoSlab(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .subtitle1))),
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
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context)
                                            .secondaryHeaderColor;
                                      },
                                    ),
                                  ),
                                  label: Text('Agregar',
                                      style: GoogleFonts.robotoSlab(
                                          fontSize: 18,
                                          color: Colors.orange,
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1)),
                                  icon: const Icon(Icons.add_box,
                                      color: Colors.orangeAccent),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      ahorro = Ahorro(
                                        uid: mainProvider.token,
                                        descripcion: ahorro.descripcion,
                                        monto: ahorro.monto,
                                        fechaInicio: ahorro.fechaInicio,
                                      );
                                      _movimientoService.sendToServer(ahorro);
                                      saldosCuenta(mainProvider.token);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Ingrese los campos')),
                                      );
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )))));
  }

  saldosCuenta(String uid) async {
    Cuenta cuenta = await _cuentaService.getCuenta(uid);
    cuenta.saldoAhorro = cuenta.saldoAhorro! + ahorro.monto!;
    _cuentaService.updateToServer(cuenta);
  }
}
