import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/providers/user_provider.dart';

// ignore: must_be_immutable
class InicioWidget extends StatefulWidget {
  const InicioWidget({Key? key}) : super(key: key);

  @override
  State<InicioWidget> createState() => _InicioWidgetState();
}

class _InicioWidgetState extends State<InicioWidget> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Container(
      color: Theme.of(context).primaryColor,
      width: size.width,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                padding: const EdgeInsets.all(15),
                child: Text('Hola ' + _userProvider.getNombre!,
                    style: GoogleFonts.robotoSlab(
                        color: Colors.white,
                        textStyle: Theme.of(context).textTheme.headline6))),
          ]),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  width: size.width - 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Theme.of(context).secondaryHeaderColor),
                  child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        const Icon(
                          Icons.attach_money,
                          size: 40.0,
                        ),
                        Text("1500",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.robotoSlab(
                                fontSize: 40.0,
                                textStyle:
                                    Theme.of(context).textTheme.headline5)),
                      ]))),
              const SizedBox(
                height: 60,
              ),
              //const HomeCard(),
            ],
          ))
        ],
      ),
    );
  }
}
