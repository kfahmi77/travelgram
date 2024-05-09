import 'package:get/get.dart';

import '../controllers/tiket_controller.dart';

class TiketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TiketController>(
      () => TiketController(),
    );
  }
}
