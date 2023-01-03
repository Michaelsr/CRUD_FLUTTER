import 'package:flutter/material.dart';
import 'package:flutter_crud/src/components/menu_pages.dart';

class TratamientoPages extends StatelessWidget {
  const TratamientoPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tratamiento"),
      ),
      drawer: const MenuPages(),
    );
  }
}
