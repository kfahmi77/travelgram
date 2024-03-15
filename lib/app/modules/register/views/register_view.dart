import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool passwordVisible = false;
  bool passwordVisible2 = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    passwordVisible2 = true;
  }

  RegisterController registerController = Get.put(RegisterController());

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
              Color.fromARGB(255, 0, 26, 255),
              Color.fromARGB(0, 0, 200, 255),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 32.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'BUAT AKUN',
                style: TextStyle(
                  fontSize: 30.sp,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                      child: TextFormField(
                        controller: registerController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Color.fromARGB(205, 255, 255, 255),
                            hintText: 'Email'),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                      child: TextFormField(
                        controller: registerController.namaLengkapController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Color.fromARGB(205, 255, 255, 255),
                            hintText: 'Nama Lengkap'),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                      child: TextFormField(
                        controller: registerController.noTelpController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Color.fromARGB(205, 255, 255, 255),
                            hintText: 'No Telepon'),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                      child: TextFormField(
                        controller: registerController.usernameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Color.fromARGB(205, 255, 255, 255),
                            hintText: 'Username'),
                      ),
                    ),
                    Container(
                        margin:
                            EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                        child: TextFormField(
                          controller: registerController.passwordController,
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: const Color.fromARGB(205, 255, 255, 255),
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                          ),
                        )),
                    Container(
                      margin:
                          EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                      child: TextFormField(
                        controller: registerController.passwordRepeatController,
                        obscureText: passwordVisible2,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: const Color.fromARGB(205, 255, 255, 255),
                          hintText: 'Ulangi Password',
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisible2
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                passwordVisible2 = !passwordVisible2;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 300.w,
                      height: 40.h,
                      margin:
                          EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 48, 42, 202),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {
                          registerController.postData();
                        },
                        child: const Text(
                          "Simpan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
