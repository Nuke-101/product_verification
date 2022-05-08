import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_verification/utils/auth_controller.dart';
import 'package:product_verification/utils/scan_controller.dart';
import 'package:product_verification/utils/web3_controller.dart';
import 'package:product_verification/views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:product_verification/views/loginsignup/login.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthController()));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final web3Controller = Get.put(Web3Controller());
  final scanController = Get.put(ScanController());

  Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  return MultiProvider(
    // providers: [
    //   Provider<AuthService>(
    //     create: (_) => AuthService(FirebaseAuth.instance),
    //   ),
    //   StreamProvider(
    //     create: (context) => context.read<AuthService>().authStateChanges,
    //     initialData: null,
    //   )
    // ],
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xffFFBD00, color),
        fontFamily: "Gilroy",
      ),
      home: LoginPage(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    if (user != null) {
      return HomePage();
    }
    return LoginPage();
  }
}
