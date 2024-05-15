import 'package:get/get.dart';

import '../controllers/kereta_controller.dart';

class KeretaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeretaController>(
      () => KeretaController(),
    );
  }
}
