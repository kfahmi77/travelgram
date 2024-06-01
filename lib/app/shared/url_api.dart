class UrlApi {
  static String baseUrl = 'https://dksystem.id/api/';
<<<<<<< Updated upstream
  static String urlStorage = 'https://dksystem.id/storage/';

  // static String baseUrl = 'http://192.168.64.181:8000/api/';
  // static String urlStorage = 'http://192.168.64.181:8000/storage/';
=======
  static String urlStorage = 'https://dksystem.id/storage//';

  // static String baseUrl = 'http://192.168.196.181:8000/api/';
  // static String urlStorage = 'http://192.168.196.181:8000/storage/';
>>>>>>> Stashed changes
  static String register = '${baseUrl}register';
  static String login = '${baseUrl}login';
  static String logout = '${baseUrl}logout';

  static String profile = '${baseUrl}user';
  static String updateProfile = '${baseUrl}user/update';

  static String messages = '${baseUrl}all-chats';
  static String sendMessage = '${baseUrl}chat-messages';
  static String getMessageById = '${baseUrl}get-messages';
  static String startConversation = '${baseUrl}conversations/start';

  static String searchUser = '${baseUrl}users/search';
  static String getUserById = '${baseUrl}user-by-id/search';

  static String addfriend = '${baseUrl}add-friend/';
  static String acceptFriend = '${baseUrl}accept-friend-request/';
  static String getRequestFriend = '${baseUrl}friend-requests/';

  static String addFeed = '${baseUrl}posts';
  static String getFeed = '${baseUrl}posts';
  static String getFeedById = '${baseUrl}posts/user';
  static String deleteFeed = '${baseUrl}posts';

  static String commentFeed = '${baseUrl}posts';
  static String addCommentFeed = '${baseUrl}posts';

  static String hotel = '${baseUrl}hotel';
  static String flight = '${baseUrl}flight-schedules';
  static String bus = '${baseUrl}bus-schedules';
  static String train = '${baseUrl}train-schedules';
  static String tour = '${baseUrl}tour-ticket';

  static String getCountLike = '${baseUrl}likes';
  static String likeFeed = '${baseUrl}likes';
  static String unlikeFeed = '${baseUrl}unlikes';

  static String transaction = '${baseUrl}transactions';

  static String rating = '${baseUrl}reviews';
  static String getRating = '${baseUrl}reviews/show';
  static String totalRating = '${baseUrl}reviews/total';
  static String addRating = '${baseUrl}reviews';

  static String dummyImage =
      'https://static.vecteezy.com/system/resources/thumbnails/008/442/086/small_2x/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg';
}
