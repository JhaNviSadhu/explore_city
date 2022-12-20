import 'package:explore_city/screens/home.dart';
import 'package:explore_city/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explore City',
      theme: ThemeData(
        primarySwatch: mycolor,
      ),
      home: const Homescreen(),
    );
  }
}
