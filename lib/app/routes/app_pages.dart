import 'package:get/get.dart';

import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/detail_pemesanan/bindings/detail_pemesanan_binding.dart';
import '../modules/detail_pemesanan/views/detail_pemesanan_view.dart';
import '../modules/feed/bindings/feed_binding.dart';
import '../modules/feed/views/feed_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/search_user/bindings/search_user_binding.dart';
import '../modules/search_user/views/search_user_view.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/tiket/bindings/tiket_binding.dart';
import '../modules/tiket/pesawat/bindings/pesawat_binding.dart';
import '../modules/tiket/pesawat/views/pesawat_view.dart';
import '../modules/tiket/views/tiket_view.dart';
import '../modules/user_profile/bindings/user_profile_binding.dart';
import '../modules/user_profile/views/user_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatScreenView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.TIKET,
      page: () => const TiketView(),
      binding: TiketBinding(),
    ),
    GetPage(
      name: _Paths.PESAWAT,
      page: () => const PesawatView(),
      binding: PesawatBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PEMESANAN,
      page: () => const DetailPemesananView(),
      binding: DetailPemesananBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
    ),
  ];
}
