import 'package:exam/Screen/view/SecondPage.dart';
import 'package:exam/Screen/view/addtaskPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (p0) => SecondPage(),
        'AT': (p0) => AddTaskPage(),
      },
    ),
  );
}
