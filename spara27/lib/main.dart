import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:spara27/src/pages/login_page.dart';

import 'package:spara27/src/providers/main_provider.dart';
import 'package:spara27/src/providers/user_provider.dart';
import 'package:spara27/src/theme/main_theme.dart';

// Create a reference to the cities collection
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: true);
    return FutureBuilder<bool>(
        future: mainProvider.getPreferences(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ScreenUtilInit(
                designSize: const Size(360, 800),
                builder: () => MaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: 'Spara',
                        theme: AppTheme.themeData(mainProvider.mode),
                        initialRoute: LoginPage.id,
                        routes: {
                          LoginPage.id: (context) => const LoginPage(),
                        }));
          }
          return const SizedBox.square(
              dimension: 100.0, child: CircularProgressIndicator());
        });
  }
}
