import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PerfilWidget extends StatelessWidget {
  const PerfilWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      width: 250.w,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, size: 50.h),
          Text("Inicio", style: Theme.of(context).textTheme.headline1),
          Text("Inicio", style: Theme.of(context).textTheme.headline2),
          Text("Inicio", style: Theme.of(context).textTheme.headline3),
          Text("Inicio", style: Theme.of(context).textTheme.headline4),
          Text("Inicio", style: Theme.of(context).textTheme.headline5),
          Text("Inicio", style: Theme.of(context).textTheme.headline6),
        ],
      )),
    );
  }
}
