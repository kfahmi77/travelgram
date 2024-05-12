import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgram/app/modules/detail_pemesanan/views/detail_pemesanan_view.dart';
import 'package:travelgram/app/modules/splash/views/splash_view.dart';
import 'package:travelgram/app/modules/tiket/pesawat/views/detail_pesawat_view.dart';
import 'package:travelgram/app/modules/tiket/pesawat/views/pesawat_view.dart';
import 'package:travelgram/app/shared/bottom_navigation.dart';
import 'app/modules/detail_pemesanan/views/metode_pembayaran.dart';
import 'app/modules/tiket/pesawat/views/cari_pesawat_view.dart';
import 'app/routes/app_pages.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  timeago.setLocaleMessages('id', timeago.IdMessages());
  //intialize intl
  final token = prefs.getString('token');

  runApp(
    MyApp(token: token),
  );
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyApp',
        theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
        // home: token == null ? const SplashView() : const BottomNavBar(),
        home: MetodePembayaranView(),
        getPages: AppPages.routes,
      ),
    );
  }
}
