class ApiConstants {
  // Общие константы
  static const String v = '5.199';

  // Константы для авторизации
  static const String oauthUrl =
      'https://oauth.vk.com/authorize?client_id=2685278&scope=69634&redirect_uri=https://oauth.vk.com/blank.html&display=page&response_type=token&revoke=1';
  static const String blankRedirectUri = 'https://oauth.vk.com/blank.html';

  // Константы для API
  static const String baseUrl = 'https://api.vk.com/method/';

  static const String usersGet = 'users.get';

  static const String audioGet = 'audio.get';
  static const int batchCount = 6000;
  static const int mainPageBatchCount = 16;

  static const String playlistsGet = 'audio.getPlaylists';
  static const String allFilter = 'all';
  static const String ownedfilter = 'owned';
  static const String followedfilter = 'followed';
  static const String albumsfilter = 'albums';

  static const String search = 'audio.search';
  static const String searchPlaylists = 'audio.searchPlaylists';
  static const String searchAlbums = 'audio.searchAlbums';
  static const String searchArtists = 'audio.searchArtists';
}
