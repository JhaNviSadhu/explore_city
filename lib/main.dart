import 'package:explore_city/bindings/bindings.dart';
import 'package:explore_city/screens/home.dart';
import 'package:explore_city/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'db/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: CityBindings(),
      debugShowCheckedModeBanner: false,
      title: 'Explore City',
      theme: ThemeData(
        primarySwatch: mycolor,
      ),
      home: const Homescreen(),
    );
  }
}
