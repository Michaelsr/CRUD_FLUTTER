// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  final googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearFondo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      decoration: const BoxDecoration(
        // image: DecorationImage(
        //     image: AssetImage("assets/lluvia.png"), fit: BoxFit.cover),
        color: Color.fromARGB(255, 3, 69, 156),
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Container(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            children: const <Widget>[
              Icon(
                Icons.apartment_sharp,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                'Clinica Sicuani',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 25.0),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    // final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 220.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: const EdgeInsets.symmetric(
              vertical: 30.0,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 50.0,
            ),
            decoration: BoxDecoration(
                // color: Color.fromARGB(255, 253, 253, 1),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color.fromARGB(255, 9, 88, 192),
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0,
                  )
                ]),
            child: Column(
              children: <Widget>[
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromARGB(221, 255, 255, 255),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                _BottonGoogle(context),
                const SizedBox(
                  height: 30.0,
                ),
                _BottonFb(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _BottonGoogle(BuildContext context) {
    return Center(
      child: FloatingActionButton.extended(
        onPressed: () async {
          final googleUser = await googleSignIn.signIn();
          if (googleUser != null) {
            // Navegar a la pantalla de inicio
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, 'boleta');
          }
        },
        icon: Image.asset(
          'assets/google.jpg',
          height: 31,
          width: 31,
        ),
        label: const Text('Inicia con Google'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    );
  }

  Widget _BottonFb(BuildContext context) {
    return Center(
      child: FloatingActionButton.extended(
        onPressed: () async {
          final googleUser = await googleSignIn.signIn();
          if (googleUser != null) {
            // Navegar a la pantalla de inicio
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, 'boleta');
          }
        },
        icon: Image.asset(
          'assets/fb.png',
          height: 31,
          width: 31,
        ),
        label: const Text('Inicio con Facebook'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
    );
  }
}
