import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:travelgram/app/shared/bottom_navigation.dart';
import 'package:travelgram/app/shared/url_api.dart';

class AddFeedView extends StatefulWidget {
  final String token;
  const AddFeedView({super.key, required this.token});

  @override
  createState() => _AddFeedViewState();
}

class _AddFeedViewState extends State<AddFeedView> {
  File? _image;
  TextEditingController _caption = TextEditingController();

  void postImage() async {
    var url = Uri.parse(UrlApi.addFeed);
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      'Authorization': 'Bearer ${widget.token}',
      "Content-type": "multipart/form-data",
    });

    if (_image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image_url', _image!.path));
    }

    request.fields['content'] = _caption.text;

    var response = await request.send();
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Berhasil menambahkan feed');
      Get.offAll(const BottomNavBar());
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Feed'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                controller: _caption,
                maxLength: 20,
                decoration: const InputDecoration(
                  labelText: 'Caption',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            _image != null
                ? Container(
                    height: 300.h,
                    padding: const EdgeInsets.all(12),
                    child: Image.file(_image!))
                : const Text('No image selected.'),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => ImageSourceSheet(
                    onImageSelected: (image) {
                      setState(() {
                        _image = image;
                      });
                    },
                  ),
                );
              },
              child: const Text('Pilih gambar'),
            ),
            const SizedBox(
              height: 8,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.green,
                side: const BorderSide(
                  color: Colors.green,
                ),
              ),
              onPressed: () {
                postImage();
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageSourceSheet extends StatelessWidget {
  final Function(File) onImageSelected;

  ImageSourceSheet({required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              Navigator.of(context).pop();
              _getImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () {
              Navigator.of(context).pop();
              _getImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  void _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      onImageSelected(File(pickedImage.path));
    }
  }
}
