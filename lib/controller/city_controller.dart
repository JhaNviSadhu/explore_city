import 'dart:convert';

import 'package:explore_city/model/model_city.dart';
import 'package:explore_city/model/model_state.dart';
import 'package:explore_city/utils/comman.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../db/db_helper.dart';

class CityController extends GetxController {
  final RxList<City> cityList = <City>[].obs;

  final RxList<ModelState> stateList = <ModelState>[].obs;
  var stateName = ''.obs;

  Future<void> getCity() async {
    final List<Map<String, dynamic>> city = await DBHelper().queryAllRows();
    cityList.assignAll(city.map((data) => City.fromMap(data)).toList());
  }

  addCity(City city) async {
    await DBHelper().insertTask(city);
    cityList.add(city);
    showSnackbar(MessageType.success, "City is added successfully");

    getCity();
  }

  deleteCity(int? id) async {
    await DBHelper().delete(id!);
    showSnackbar(MessageType.success, "City Deleted successfully");
    getCity();
  }

  updateCity(City city) async {
    await DBHelper().updateAllFields(city);
    showSnackbar(MessageType.success, "City updated successfully");
    getCity();
  }

  loadStateList() async {
    try {
      String response = await rootBundle.loadString('assets/statename.json');

      List<dynamic> result = json.decode(response);
      stateList.value = result.map((n) => ModelState.fromMap(n)).toList();
      return stateList;
    } catch (e) {
      throw const Padding(
        padding: EdgeInsets.only(top: 50),
        child: Center(
          child: Text('Convert Error'),
        ),
      );
    }
  }
}
