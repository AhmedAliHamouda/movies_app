import 'genre.dart';

class GenreResponse {
  List<Genre> genres;
  String error;

  GenreResponse({this.genres, this.error});

  GenreResponse.fromJson(Map<String, dynamic> json)
      : genres =
            (json["genres"] as List).map((i) => new Genre.fromJson(i)).toList(),
        error = "";

  GenreResponse.withError(String errorValue)
      : genres = List(),
        error = errorValue;
}
