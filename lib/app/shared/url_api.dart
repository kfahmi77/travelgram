class UrlApi {
  // static String baseUrl = 'https://dksystem.id/api/';
  // static String urlStorage = 'https://dksystem.id/storage//';

  static String baseUrl = 'http://192.168.196.181:8000/api/';
  static String urlStorage = 'http://192.168.196.181:8000/storage//';
  static String register = '${baseUrl}register';
  static String login = '${baseUrl}login';
  static String logout = '${baseUrl}logout';

  static String messages = '${baseUrl}all-chats';
  static String sendMessage = '${baseUrl}chat-messages';
  static String getMessageById = '${baseUrl}get-messages';
  static String startConversation = '${baseUrl}conversations/start';

  static String searchUser = '${baseUrl}users/search';

  static String addfriend = '${baseUrl}add-friend/';
  static String acceptFriend = '${baseUrl}accept-friend-request/';
  static String getRequestFriend = '${baseUrl}friend-requests/';

  static String addFeed = '${baseUrl}posts';
  static String getFeed = '${baseUrl}posts';
  static String deleteFeed = '${baseUrl}posts';

  static String commentFeed = '${baseUrl}posts';
  static String addCommentFeed = '${baseUrl}posts';

  static String dummyImage =
      'https://static.vecteezy.com/system/resources/thumbnails/008/442/086/small_2x/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg';
}
