import 'package:flutter/cupertino.dart';

/// Has all urls used in the app as static const strings.
class Url {
  //Base URLs
  static const jikanBaseUrl = 'https://api.jikan.moe/v3';

  // A single anime object with all its details
  //Endpoint Path: /anime/{id}(/request)
  static String animeDetailsUrl(
      {@required int id, Request request, String type = 'anime'}) {
    //return '$jikanBaseUrl/anime/$id/${request != null ? animeDetailsMap[request] : null}';
    return request != null
        ? '$jikanBaseUrl/$type/$id/${animeDetailsMap[request]}'
        : '$jikanBaseUrl/$type/$id';
  }

  static String animeCategoryUrl({@required Category category, int page = 1}) {
    return '$jikanBaseUrl/top/anime/$page/${animeCategoryMap[category]}';
  }

  static String mangaCategoryUrl({@required int page}) {
    return '$jikanBaseUrl/top/manga/$page';
  }

  static String search({@required String query}) {
    return '$jikanBaseUrl/search/anime?q=$query';
  }

  // About page
  static const authorProfile = 'https://twitter.com/bahaafathi';
  static const authorPatreon = 'https://www.patreon.com/bahaafathi';
  static const emailUrl =
      'mailto:BahaaFathi@outlook.sa?subject=About Anime Slayer!';

  static const changelog = 'https://raw.githubusercontent.com/bahaafathi';
  static const appSource = 'https://github.com/bahaafathi/AnimeSlayer';
  static const apiSource = 'jikan.docs.apiary.io/';
  static const flutterPage = 'https://flutter.dev';
}

Map<Category, String> animeCategoryMap = {
  Category.airing: 'airing',
  Category.upcoming: 'upcoming',
  Category.movie: 'movie',
  Category.ova: 'ova',
  Category.special: 'special'
};
Map<Request, String> animeDetailsMap = {
  Request.pictures: 'pictures',
  Request.characters_staff: 'characters_staff',
  Request.episodes: 'episodes',
  Request.recommendations: 'recommendations',
  Request.reviews: 'reviews',
  Request.videos: 'videos',
  Request.news: 'news',
};
enum Request {
  characters_staff,
  episodes,
  news,
  pictures,
  videos,
  reviews,
  recommendations,
  userupdates
}
enum Category {
  airing,
  upcoming,
  movie,
  ova,
  special,
}
