import 'package:get/get.dart';

import '../controllers/search_user_controller.dart';

class SearchUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchUserController>(
      () => SearchUserController(),
    );
  }
}
