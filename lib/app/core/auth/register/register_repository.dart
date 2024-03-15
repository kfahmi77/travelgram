import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> postData() async {
  final url = Uri.parse('http://192.168.242.181:80/api/register');
 
  final response = await http.post(
    url,
    headers: <String, String>{
      'Accept': 'application/json',
    },
    body: {
      'nama_lengkap': 'John Doe',
      'username': 'john',
      'email': 'john@gmail.com',
      'no_telp': '081234567',
      'password': 'password',
    },
  );

  if (response.statusCode == 200) {
    print('Post successful');
    print(response.body);
  } else {
    print('Post failed with status: ${response.statusCode}');
    print(response.body);
  }
}
