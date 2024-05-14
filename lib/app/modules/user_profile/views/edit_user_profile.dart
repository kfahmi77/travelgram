// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelgram/app/modules/user_profile/models/user_profile_model.dart';
import 'package:travelgram/app/shared/bottom_navigation.dart';
import 'package:travelgram/app/shared/url_api.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  UserProfileModel? profileData;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String? token;

  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initilaizeToken();
  }

  Future<void> initilaizeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    setState(() {
      token = token;
    });
    await _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    final response = await http.get(Uri.parse(UrlApi.profile), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      setState(() {
        profileData = UserProfileModel.fromJson(jsonDecode(response.body));
        _namaLengkapController.text = profileData!.namaLengkap;
        _usernameController.text = profileData!.username;
        _emailController.text = profileData!.email;
        _noTelpController.text = profileData!.noTelp;
      });
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _noTelpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: profileData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: _selectedImage == null &&
                                  profileData!.avatar == null
                              ? const Icon(Icons.add_a_photo)
                              : ClipOval(
                                  child: _selectedImage != null
                                      ? Image.file(_selectedImage!,
                                          fit: BoxFit.cover)
                                      : Image.network(
                                          '${UrlApi.urlStorage}${profileData!.avatar!}',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _namaLengkapController,
                        decoration:
                            const InputDecoration(labelText: 'Nama Lengkap'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        readOnly: true,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _noTelpController,
                        decoration:
                            const InputDecoration(labelText: 'No Telepon'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _updateProfile(UserProfileModel(
                              id: profileData!.id,
                              namaLengkap: _namaLengkapController.text,
                              username: _usernameController.text,
                              email: _emailController.text,
                              noTelp: _noTelpController.text,
                              emailVerifiedAt: profileData!.emailVerifiedAt,
                              avatar: profileData!.avatar,
                              createdAt: profileData!.createdAt,
                              updatedAt: profileData!.updatedAt,
                            ));
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _updateProfile(UserProfileModel updatedProfile) async {
    // Create multipart request for image upload
    var request =
        http.MultipartRequest('POST', Uri.parse(UrlApi.updateProfile));

    // Menambahkan header otorisasi jika diperlukan
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['id'] = updatedProfile.id.toString();
    request.fields['nama_lengkap'] = updatedProfile.namaLengkap;
    request.fields['username'] = updatedProfile.username;
    request.fields['no_telp'] = updatedProfile.noTelp;

    if (_selectedImage != null) {
      request.files.add(
          await http.MultipartFile.fromPath('avatar', _selectedImage!.path));
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Profile updated successfully');
        await Get.offAll(BottomNavBar(index: 0));

        // Save avatar URL to SharedPreferences if it was updated
        if (_selectedImage != null) {
          var responseData = await http.Response.fromStream(response);
          var responseJson = jsonDecode(responseData.body);
          var updatedAvatarUrl = responseJson['avatar'];
          var updateUsername = responseJson['username'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('avatar_url', updatedAvatarUrl);
          await prefs.setString('username', updateUsername);
        }

        // Fetch the updated profile data
        _fetchProfileData();
      } else if (response.statusCode == 302) {
        var responseString = await response.stream.bytesToString();
        print('Failed to update profile. Status code: ${response.statusCode}');
        print('Response: $responseString');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred')),
      );
    }
  }
}
