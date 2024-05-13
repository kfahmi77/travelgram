
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

Future<void> saveIdUser(String idUser) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('id', idUser);

}
Future<void> saveUsername (String username) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);
}

Future<void> saveImageUrl (String imageUrl) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('avatar', imageUrl);
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token != null) {
    print('Token: $token');
    return token;
  } else {
    print('Token not found');
    return null;
  }
}

Future<String?> getIdUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? idUser = prefs.getString('id');

  if (idUser != null) {
    print('Id User: $idUser');
    return idUser;
  } else {
    print('Id User not found');
    return null;
  }
}

//remove token
Future<void> removeToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}
