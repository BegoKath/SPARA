import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/utils/main_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spara27/src/providers/main_provider.dart';

final List<String> _options = ["Inicio", "Movimientos", "Ahorros", "Perfil"];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
          leading: SizedBox.square(
              dimension: 40.0,
              child: Switch(
                value: mainProvider.mode,
                onChanged: (bool value) async {
                  mainProvider.mode = value;
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool("mode", value);
                },
              )),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: NetworkImage(
                    "https://res.cloudinary.com/dvpl8qsgd/image/upload/v1639900999/SPARA/Property_1_Default_iuphlt.png"),
                fit: BoxFit.contain,
                height: 50,
              ),
            ],
          )),
      body: Stack(
        children: [
          contentWidgets[mainProvider.index],
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 80,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        elevation: 0.1,
                        onPressed: () {}),
                  ),
                  Container(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.home,
                              color: currentIndex == 0
                                  ? Theme.of(context).secondaryHeaderColor
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              mainProvider.index = 0;
                              setBottomBarIndex(mainProvider.index);
                            },
                            splashColor: Colors.white,
                            iconSize: 20.0),
                        IconButton(
                            icon: Icon(
                              Icons.account_balance_wallet_outlined,
                              color: currentIndex == 1
                                  ? Theme.of(context).secondaryHeaderColor
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              mainProvider.index = 1;
                              setBottomBarIndex(mainProvider.index);
                            },
                            iconSize: 28.0),
                        Container(
                          width: size.width * 0.20,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.attach_money_outlined,
                            color: currentIndex == 2
                                ? Theme.of(context).secondaryHeaderColor
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            mainProvider.index = 2;
                            setBottomBarIndex(mainProvider.index);
                          },
                          iconSize: 28.0,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color: currentIndex == 3
                                  ? Theme.of(context).secondaryHeaderColor
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              mainProvider.index = 3;
                              setBottomBarIndex(mainProvider.index);
                            },
                            iconSize: 20.0),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //Dibujo del la barra de navegacion
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

@override
Widget build(BuildContext context) {
  throw UnimplementedError();
}
