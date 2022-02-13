import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/pages/ahorro_page.dart';
import 'package:spara27/src/pages/movimiento_page.dart';
import 'package:spara27/src/utils/main_menu.dart';
import 'package:spara27/src/providers/main_provider.dart';
import 'package:intl/date_symbol_data_local.dart';

//final List<String> _options = ["Inicio", "Movimientos", "Ahorros", "Perfil"];

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
  void initState() {
    initializeDateFormatting("es_ES");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
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
            top: 590,
            child: SizedBox(
              width: size.width,
              height: 80,
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(size.width, 80),
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(
                        backgroundColor: Theme.of(context).secondaryHeaderColor,
                        child: Icon(Icons.add, color: Colors.cyan.shade800),
                        elevation: 0.1,
                        splashColor: Colors.cyan.shade800,
                        focusColor: Colors.cyan.shade800,
                        onPressed: () {
                          opciones(context);
                        }),
                  ),
                  SizedBox(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            icon: Icon(Icons.home,
                                color: currentIndex == 0
                                    ? Colors.cyan.shade200
                                    : Theme.of(context).secondaryHeaderColor),
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
                                  ? Colors.cyan.shade200
                                  : Theme.of(context).secondaryHeaderColor,
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
                                ? Colors.cyan.shade200
                                : Theme.of(context).secondaryHeaderColor,
                          ),
                          onPressed: () {
                            mainProvider.index = 2;
                            setBottomBarIndex(mainProvider.index);
                          },
                          iconSize: 28.0,
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.settings,
                              color: currentIndex == 3
                                  ? Colors.cyan.shade200
                                  : Theme.of(context).secondaryHeaderColor,
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
      ..color = Colors.black45
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
    canvas.drawShadow(path, Colors.cyan.shade600, 4, true);
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

void opciones(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        final Size size = MediaQuery.of(context).size;
        return Stack(children: [
          Positioned(
            bottom: 90,
            left: size.width / 8,
            child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MovimientoPage(tipo: true),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_circle_up_outlined,
                    color: Colors.greenAccent.shade700),
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                label: Text(
                  "Ingreso",
                  style: GoogleFonts.lora(
                      color: Colors.green,
                      fontSize: 15,
                      textStyle: Theme.of(context).textTheme.bodyText1),
                )),
          ),
          Positioned(
            bottom: 90,
            right: size.width / 8,
            child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MovimientoPage(tipo: false),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_circle_down_outlined,
                    color: Colors.redAccent.shade700),
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                label: Text(
                  "Egreso",
                  style: GoogleFonts.lora(
                      color: Colors.red,
                      fontSize: 15,
                      textStyle: Theme.of(context).textTheme.bodyText1),
                )),
          ),
          Positioned(
            bottom: 150,
            left: size.width / 3,
            child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AhorroFormPage(),
                    ),
                  );
                },
                icon: Icon(Icons.savings_outlined,
                    color: Colors.orangeAccent.shade700),
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                label: Text(
                  "Ahorro",
                  style: GoogleFonts.lora(
                      color: Colors.orange,
                      fontSize: 15,
                      textStyle: Theme.of(context).textTheme.bodyText1),
                )),
          ),
        ]);
      });
}
