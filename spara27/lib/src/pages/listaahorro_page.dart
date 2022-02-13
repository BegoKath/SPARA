import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spara27/src/models/ahorro_model.dart';
import 'package:spara27/src/widgets/ahorro_card.dart';

class AhorrosPage extends StatefulWidget {
  const AhorrosPage({Key? key, required this.modelos, required this.mes})
      : super(key: key);
  final List<Ahorro> modelos;
  final String mes;
  @override
  State<AhorrosPage> createState() => _AhorrosPageState();
}

class _AhorrosPageState extends State<AhorrosPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: Row(
        children: const [
          Image(
            image: NetworkImage(
                "https://res.cloudinary.com/dvpl8qsgd/image/upload/v1639900999/SPARA/Property_1_Default_iuphlt.png"),
            fit: BoxFit.contain,
            height: 50,
          ),
        ],
      )),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              widget.mes.toUpperCase(),
              textAlign: TextAlign.justify,
              style: GoogleFonts.lora(
                  color: Colors.white,
                  textStyle: Theme.of(context).textTheme.headline5),
            ),
          ),
          listaAhorro1Widget(),
        ],
      )),
    ));
  }

  Widget listaAhorro1Widget() {
    // ignore: unnecessary_null_comparison
    return widget.modelos == null
        ? const Center(
            child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(color: Colors.white)))
        : widget.modelos.isEmpty
            ? Center(
                child: SizedBox(
                    child: Text("No tienes Ahorros",
                        style: GoogleFonts.robotoSlab(
                            color: Colors.cyan.shade400,
                            textStyle: Theme.of(context).textTheme.bodyText2))))
            : Expanded(
                child: ListView(
                children:
                    widget.modelos.map((e) => AhorroCard(model: e)).toList(),
              ));
  }
}
