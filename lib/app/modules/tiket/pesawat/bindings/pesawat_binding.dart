import 'package:get/get.dart';

import '../controllers/pesawat_controller.dart';

class PesawatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesawatController>(
      () => PesawatController(),
    );
  }
}
