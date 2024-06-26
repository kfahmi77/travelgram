import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:travelgram/app/modules/login/controllers/login_controller.dart';

import '../../../shared/bottom_navigation.dart';
import '../../register/views/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isRememberMe = false;
  
  LoginController loginController = Get.put(LoginController());
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Color(0x006f7bf7),
          ],
        ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              Image.asset(
                "assets/images/logo.png",
                width: 200.w,
                fit: BoxFit.fill,
              ),
              Container(
                width: 250.w,
                height: 340.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    //create textfield rounded
                    Container(
                      margin:
                          EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                      child: TextField(
                        controller: loginController.emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(217, 217, 217, 1),
                          hintText: "Email",
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/user.png",
                              width: 30.0,
                              height: 30.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),

                    Container(
                      margin:
                          EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                      child: TextField(
                        controller: loginController.passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(217, 217, 217, 1),
                          hintText: "Password",
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/images/lock.png",
                              width: 25.0,
                              height: 25.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: 300.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.blue),
                      margin:
                          EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () =>
                              ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Masih dalam tahap pengembangan"),
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "assets/images/google.png",
                                  width: 32.w,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                "Lanjutkan dengan Google",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    //create a checkbox
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isRememberMe,
                          onChanged: (value) {
                            setState(() {
                              isRememberMe = value!;
                            });
                          },
                        ),
                        const Text(
                          "Ingat saya",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "Tidak ingat kata sandi?",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 18.w,
                        ),
                      ],
                    ),

                    InkWell(
                      onTap: () {
                        loginController.login();
                      },
                      child: Container(
                        width: 300.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromARGB(255, 122, 101, 180),
                        ),
                        margin:
                            EdgeInsets.only(top: 8.h, left: 20.w, right: 20.w),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        const Text(
                          "Belum punya akun?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        const Spacer(),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.to(() => const RegisterView());
                          },
                          child: const Text(
                            "Daftar",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
