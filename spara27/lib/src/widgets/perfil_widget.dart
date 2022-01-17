import 'package:flutter/material.dart';

class PerfilWidget extends StatelessWidget {
  const PerfilWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: Theme.of(context).primaryColor,
      width: size.width,
    );
  }
}
