// @dart=2.18
import 'package:flutter/material.dart';
import 'package:flutter_crud/src/pages/boleta_pages.dart';
import 'package:flutter_crud/src/pages/login_pages.dart';
import 'package:flutter_crud/src/pages/menu_pages.dart';
import 'package:flutter_crud/src/pages/tratamiento.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: 'login',
      routes: {
        'login': (context) => const LoginPages(),
        'menu': (context) => const MenuPages(),
        'boleta': (context) => const BoletaPages(),
        'tratamiento': (context) => const TratamientoPages(),
      },
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 9, 88, 192),
      ),
    );
  }
}
