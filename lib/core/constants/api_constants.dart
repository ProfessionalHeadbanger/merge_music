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
  static const int playlistAudiosBatchCount = 1000;

  static const String playlistsGet = 'audio.getPlaylists';
  static const String allFilter = 'all';
  static const String ownedfilter = 'owned';
  static const String followedfilter = 'followed';
  static const String albumsfilter = 'albums';

  static const String search = 'audio.search';
  static const String searchPlaylists = 'audio.searchPlaylists';
  static const String searchAlbums = 'audio.searchAlbums';
  static const String searchArtists = 'audio.searchArtists';

  static const String getArtistById = 'audio.getArtistById';
  static const String getAlbumsByArtist = 'audio.getAlbumsByArtist';
  static const String getAudiosByArtist = 'audio.getAudiosByArtist';

  static const String getRecommendations = 'audio.getRecommendations';

  static const String add = 'audio.add';
  static const String delete = 'audio.delete';
  static const String followPlaylist = 'audio.followPlaylist';
  static const String deletePlaylist = 'audio.deletePlaylist';
  static const String restore = 'audio.restore';
}

class DeezerApiConstants {
  static const String baseUrl = 'https://api.deezer.com/';

  static const String search = 'search';
}
