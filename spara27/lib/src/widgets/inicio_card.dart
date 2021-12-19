import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.only(top: 50.0),
      elevation: 5,
      shadowColor: Theme.of(context).secondaryHeaderColor,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 400,
        width: size.width - 20,
        child: Center(
            child: Column(
          children: [Text("GRAFICO PASTEL"), Text("Categorias")],
        )),
      ),
    );
  }
}
