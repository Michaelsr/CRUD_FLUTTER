import 'package:flutter/material.dart';
import 'package:flutter_crud/src/controller/login_controller.dart';
import 'package:get/get.dart';

class MenuPages extends StatelessWidget {
  MenuPages({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.googleAccount.value?.email ?? ''),
      ),
    );
  }
}
