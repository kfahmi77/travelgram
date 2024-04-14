class UrlApi {
  static String baseUrl = 'http://192.168.173.181:8080/api/';
  static String storage = 'http://192.168.173.181:8080/storage';
  static String register = '${baseUrl}register';
  static String login = '${baseUrl}login';
  static String logout = '${baseUrl}logout';

  static String messages = '${baseUrl}all-chats';
  static String sendMessage = '${baseUrl}chat-messages';
  static String getMessageById = '${baseUrl}get-messages';

  static String searchUser = '${baseUrl}user/search';
}
