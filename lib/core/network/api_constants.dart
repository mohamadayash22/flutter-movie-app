class ApiConstants {
  ApiConstants._();

  static const String baseBackdropUrl = 'https://image.tmdb.org/t/p/w1280';
  static const String basePosterUrl = 'https://image.tmdb.org/t/p/w500';
  static const String baseProfileUrl = 'https://image.tmdb.org/t/p/w300';
  static const String baseStillUrl = 'https://image.tmdb.org/t/p/w500';
  static const String baseAvatarUrl = 'https://image.tmdb.org/t/p/w185';
  static const String baseVideoUrl = 'https://www.youtube.com/watch?v=';

  static const String moviePlaceHolder =
      'https://davidkoepp.com/wp-content/themes/blankslate/images/Movie%20Placeholder.jpg';

  static const String castPlaceHolder =
      'https://palmbayprep.org/wp-content/uploads/2015/09/user-icon-placeholder.png';

  static const String avatarPlaceHolder =
      'https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049__480.png';

  static const String stillPlaceHolder =
      'https://popcornsg.s3.amazonaws.com/gallery/1577405144-six-year.png';

  // movies paths
  static String nowPlayingMoviesPath = '/movie/now_playing';
  static String popularMoviesPath = '/movie/popular';
  static String topRatedMoviesPath = '/movie/top_rated';
  static String movieDetailsPath(int movieId) => '/movie/$movieId';

  // tv shows paths
  static String onAirTvShowsPath = '/tv/on_the_air';
  static String popularTvShowsPath = '/tv/popular';
  static String topRatedTvShowsPath = '/tv/top_rated';
  static String tvShowDetailsPath(int tvShowId) => '/tv/$tvShowId';
  static String seasonDetailsPath({
    required int id,
    required int seasonNumber,
  }) {
    return '/tv/$id/season/$seasonNumber';
  }

  // search path
  static String searchPath = '/search/multi';
}
