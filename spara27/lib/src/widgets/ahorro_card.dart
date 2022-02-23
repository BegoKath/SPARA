import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spara27/src/models/ahorro_model.dart';

class AhorroCard extends StatelessWidget {
  const AhorroCard({Key? key, required this.model}) : super(key: key);
  final Ahorro model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Theme.of(context).secondaryHeaderColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(Icons.savings),
          Text(model.descripcion!,
              style: GoogleFonts.robotoSlab(
                fontSize: 20.0,
              )),
          Row(
            children: [
              const Icon(
                Icons.attach_money,
                color: Colors.orange,
                size: 25,
              ),
              Text(model.monto.toString(),
                  style: GoogleFonts.robotoSlab(
                      fontSize: 30.0, color: Colors.orange))
            ],
          ),
        ],
      ),
    );
  }
}
