import 'package:explore_city/controller/city_controller.dart';
import 'package:get/get.dart';

class CityBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CityController(), fenix: true);
  }
}
