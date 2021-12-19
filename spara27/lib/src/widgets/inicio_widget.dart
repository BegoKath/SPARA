import 'package:flutter/material.dart';
import 'package:spara27/src/widgets/inicio_card.dart';

class InicioWidget extends StatelessWidget {
  const InicioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).primaryColor,
      width: size.width,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                padding: EdgeInsets.all(15),
                child: Text('Hola nombre!',
                    style: Theme.of(context).textTheme.headline6)),
          ]),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 100,
                  padding: const EdgeInsets.all(20),
                  width: size.width - 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Theme.of(context).primaryColorLight),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Saldo",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle1),
                        Text("1500",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5),
                      ],
                    ),
                  )),
              const HomeCard(),
            ],
          ))
        ],
      ),
    );
  }
}
