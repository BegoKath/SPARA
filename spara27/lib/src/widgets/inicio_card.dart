import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.only(top: 50.0),
      elevation: 5,
      color: Theme.of(context).secondaryHeaderColor,
      shadowColor: Theme.of(context).secondaryHeaderColor,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 200,
        width: size.width - 20,
        child: Center(
            child: Column(
          children: const [Text("GRAFICO PASTEL"), Text("Categorias")],
        )),
      ),
    );
  }
}
