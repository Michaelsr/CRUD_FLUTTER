import 'package:flutter/material.dart';

class MenuPages extends StatefulWidget {
  const MenuPages({super.key});

  @override
  State<MenuPages> createState() => _MenuPagesState();
}

class _MenuPagesState extends State<MenuPages> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        backgroundColor: const Color.fromARGB(255, 9, 88, 192),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("data"),
              accountEmail: Text("demaata"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.amber,
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 64, 141, 241),
              ),
            ),
            ListTile(
              title: const Text('Boleta'),
              textColor: Colors.white,
              onTap: () {
                // Actualiza el estado de la aplicación
                // ...
                // Luego cierra el drawer
                Navigator.pushNamed(context, 'boleta');
              },
            ),
            ListTile(
              title: const Text('Tratamiento'),
              textColor: Colors.white,
              onTap: () {
                Navigator.pushNamed(context, 'tratamiento');
              },
            ),
            ListTile(
              title: const Text('Salir'),
              textColor: Colors.white,
              onTap: () {
                Navigator.pushNamed(context, 'login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
