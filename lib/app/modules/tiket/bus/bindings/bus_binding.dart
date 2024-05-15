import 'package:get/get.dart';

import '../controllers/bus_controller.dart';

class BusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusController>(
      () => BusController(),
    );
  }
}
