import 'package:get/get.dart';

import '../controllers/detail_pemesanan_controller.dart';

class DetailPemesananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPemesananController>(
      () => DetailPemesananController(),
    );
  }
}
