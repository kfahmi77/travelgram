import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgram/app/modules/home/views/home_view.dart';
import 'package:travelgram/app/modules/user_profile/views/user_profile_view.dart';
import 'package:travelgram/app/routes/app_pages.dart';

import '../modules/feed/views/add_feed_view.dart';
import '../modules/search/views/search_view.dart';
import '../modules/tiket/views/tiket_view.dart';

class BottomNavBar extends StatefulWidget {
  final int index;
  const BottomNavBar({required this.index, super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  String? _token;
  late PageController _pageController;
  late NotchBottomBarController _controller;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _controller = NotchBottomBarController(index: widget.index);

    initializeToken();
  }

  void initializeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      setState(() {
        _token = token;
      });
    }
  }

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      const HomeView(),
      const TiketView(),
      AddFeedView(token: _token ?? ''),
      UserSearchPage(token: _token ?? ''),
      UserProfileView(token: _token ?? '')
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: false,
              shadowElevation: 0,
              kBottomRadius: 10.0,

              // notchShader: const SweepGradient(
              //   startAngle: 0,
              //   endAngle: pi / 2,
              //   colors: [Colors.red, Colors.green, Colors.orange],
              //   tileMode: TileMode.mirror,
              // ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
              notchColor: Colors.black,

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: true,
              durationInMilliSeconds: 800,

              bottomBarItems: [
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: Colors.black,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 1',
                ),
                BottomBarItem(
                  inActiveItem: Image.asset(
                    "assets/images/plane.png",
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.fill,
                  ),
                  activeItem: Image.asset(
                    "assets/images/plane.png",
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.fill,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 2',
                ),
                BottomBarItem(
                  inActiveItem: Image.asset(
                    "assets/images/add.png",
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.fill,
                  ),
                  activeItem: Image.asset(
                    "assets/images/add.png",
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.fill,
                  ),
                  itemLabel: 'Page 3',
                ),
                BottomBarItem(
                  inActiveItem: Image.asset(
                    "assets/images/lucide_search.png",
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.fill,
                    color: Colors.black,
                  ),
                  activeItem: Image.asset(
                    "assets/images/lucide_search.png",
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.fill,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 4',
                ),
                BottomBarItem(
                  inActiveItem: Image.asset(
                    "assets/images/material-symbols_person.png",
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.fill,
                    color: Colors.black,
                  ),
                  activeItem: Image.asset(
                    "assets/images/material-symbols_person.png",
                    width: 30.0,
                    height: 30.0,
                    fit: BoxFit.fill,
                    color: Colors.white,
                  ),
                  itemLabel: 'Page 5',
                ),
              ],
              onTap: (index) {
                /// perform action on tab change and to update pages you can update pages without pages
                log('current selected index $index');
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: () {
                logout();
              },
              child: const Text("Save"),
            ),
            const Text('Page 1'),
          ],
        )));
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green, child: const Center(child: Text('Page 2')));
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red, child: const Center(child: Text('Page 3')));
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue, child: const Center(child: Text('Page 4')));
  }
}

class Page5 extends StatelessWidget {
  const Page5({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey, child: const Center(child: Text('Page 5')));
  }
}

void logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  Get.offAllNamed(Routes.LOGIN);
}
