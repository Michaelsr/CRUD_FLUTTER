import 'package:flutter/material.dart';

class MenuPages extends StatelessWidget {
  const MenuPages({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        backgroundColor: const Color.fromARGB(255, 9, 88, 192),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 64, 141, 241),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.amber,
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
