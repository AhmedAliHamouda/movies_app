import 'package:dio/dio.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/models/genre_response.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/models/movie_response.dart';
import 'package:movie_app/models/person_detail.dart';
import 'package:movie_app/models/person_images.dart';
import 'package:movie_app/models/person_movies_response.dart';
import 'package:movie_app/models/person_response.dart';
import 'package:movie_app/models/video.dart';

class MovieRepository {
  final String apiKey = '5af3db634899a5f2320bedb9d54a41c1';
  static String mainUrl = 'https://api.themoviedb.org/3';
  final Dio _dio = Dio();
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = "$mainUrl/genre/movie/list";
  var getPersonsUrl = "$mainUrl/trending/person/week";
  var getPersonDetailUrl='$mainUrl/person';
  var getSearchMoviesUrl = "$mainUrl/search/movie";
  var movieUrl = "$mainUrl/movie";


  Future<List<PersonImages>> getPersonImage(int personId)async{

    var params = {
      'api_key': apiKey,
    };
    try {
      Response response =
          await _dio.get(getPersonDetailUrl + '/$personId/images', queryParameters: params);
      final personImagesList = (response.data)['profiles'] as List;
      return personImagesList.map((personImages) => PersonImages.fromJson(personImages)).toList();
    } catch (error) {
      print('Exception : $error');
      return null;
    }

  }

  Future<PersonMovieResponse> getPersonMovies(int personId)async{

    var params = {
      "api_key": apiKey,
    };

    try {
      Response response =
      await _dio.get(getPersonDetailUrl + '/$personId/movie_credits', queryParameters: params);
      return PersonMovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PersonMovieResponse.withError("$error");
    }


  }


  Future<PersonDetail> getPersonDetail(int personId)async{

    var params = {
      'api_key': apiKey,
    };
    try {
      Response response =
      await _dio.get(getPersonDetailUrl + '/$personId', queryParameters: params);
      return PersonDetail.fromJson(response.data);
    } catch (error) {
      print('Exception : $error');
      return null;
    }

  }



  Future<MovieResponse> getSearchMovies(String searchQuery) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "query":searchQuery,
    };

    try {
      Response response =
      await _dio.get(getSearchMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getPopularMovies() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  // Future<List<Movie>> getPopularMovies() async {
  //
  //   List<Movie> extractedMovies=[];
  //   var params = {
  //     'api_key': apiKey,
  //     'language': 'en_US',
  //     'page': 1,
  //   };
  //   try {
  //     Response response =
  //         await _dio.get(getPopularUrl, queryParameters: params);
  //     final movies=(response.data)['results'] as List;
  //     extractedMovies= movies.map((movie) => Movie.fromJson(movie)).toList();
  //   } catch (error) {
  //     print('Exception : $error');
  //   }
  //   return extractedMovies;
  //
  // }

  Future<MovieResponse> getPlayingMovies() async {
    var params = {
      'api_key': apiKey,
      'language': 'en_US',
      'page': 1,
    };
    try {
      Response response =
          await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error) {
      print('Exception : $error');
      return MovieResponse.withError('$error');
    }
  }

  Future<GenreResponse> getGenresMovies() async {
    var params = {
      'api_key': apiKey,
      'language': 'en_US',
      'page': 1,
    };
    try {
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch (error) {
      print('Exception : $error');
      return GenreResponse.withError('$error');
    }
  }

  Future<PersonResponse> getPersonsMovies() async {
    var params = {
      'api_key': apiKey,
    };
    try {
      Response response =
          await _dio.get(getPersonsUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (error) {
      print('Exception : $error');
      return PersonResponse.withError('$error');
    }
  }

  Future<MovieResponse> getMovieByGenre(int id) async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1,
      'with_genres': id
    };
    try {
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error) {
      print('Exception : $error');
      return MovieResponse.withError('$error');
    }
  }

  Future<MovieDetail> getMovieDetail(int idMovie) async {
    //List<MovieDetail> extractedData;

    var params = {
      'api_key': apiKey,
      'language': 'en_US',
    };
    try {
      Response response =
          await _dio.get(movieUrl + '/$idMovie', queryParameters: params);
      return MovieDetail.fromJson(response.data);
      // final movieDetailList = (response.data)['results'] as List;
      // return movieDetailList
      //     .map((movieDetail) => MovieDetail.fromJson(movieDetail))
      //     .toList();
    } catch (error) {
      print('Exception : $error');
      return null;
    }
  }

  Future<List<Cast>> getCasts(int id) async {
    var params = {
      'api_key': apiKey,
      'language': 'en_US',
    };
    //print('this ID : $id');
    try {
      Response response =
          await _dio.get(movieUrl + '/$id/credits', queryParameters: params);
      final castList = (response.data)['cast'] as List;
      return castList.map((cast) => Cast.fromJson(cast)).toList();
    } catch (error) {
      print('Exception : $error');
      return [];
    }
  }

  Future<MovieResponse> getSimilarMovies(int idMovie) async {
    var params = {
      'api_key': apiKey,
      'language': 'en_US',
    };
    try {
      Response response = await _dio.get(movieUrl + '/$idMovie/similar',
          queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print('Exception : $error stackTrace: $stackTrace');
      return MovieResponse.withError('$error');
    }
  }

  Future<List<Video>> getMovieVideos(int id) async {
    var params = {
      'api_key': apiKey,
      'language': 'en_US',
    };
    try {
      Response response =
          await _dio.get(movieUrl + '/$id/videos', queryParameters: params);
      final videoList = (response.data)['results'] as List;
      return videoList.map((video) => Video.fromJson(video)).toList();
    } catch (error) {
      print('Exception : $error');
      return [];
    }
  }
}
