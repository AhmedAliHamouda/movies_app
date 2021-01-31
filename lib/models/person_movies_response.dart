
import 'package:movie_app/models/movie.dart';

class PersonMovieResponse {
  List<Movie> movies;
  String error;

  PersonMovieResponse({this.movies, this.error});

  PersonMovieResponse.fromJson(Map<String, dynamic> json)
      : movies = (json["cast"] as List).map((item) => new Movie.fromJson(item)).toList(),
        error = "";

  PersonMovieResponse.withError(String errorValue)
      : movies = List(),
        error = errorValue;
}