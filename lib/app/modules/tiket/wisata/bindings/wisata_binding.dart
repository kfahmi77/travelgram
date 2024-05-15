import 'package:get/get.dart';

import '../controllers/wisata_controller.dart';

class WisataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WisataController>(
      () => WisataController(),
    );
  }
}
