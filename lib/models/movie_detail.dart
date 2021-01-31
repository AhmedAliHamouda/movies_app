import 'genre.dart';

class MovieDetail {
  int id;
  bool adult;
  int budget;
  List<Genre> genres;
  String releaseDate;
  int runtime;

  MovieDetail(this.id, this.adult, this.budget, this.genres, this.releaseDate,
      this.runtime);

  MovieDetail.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    adult = json["adult"];
    budget = json["budget"];
    genres =
        (json["genres"] as List).map((item) => Genre.fromJson(item)).toList();
    releaseDate = json["release_date"];
    runtime = json["runtime"];
  }

//   factory MovieDetail.fromJson(Map<String, dynamic> json) {
//     return MovieDetail(
//       json["id"],
//       json["adult"],
//       json["budget"],
//       (json["genres"] as List).map((item) => Genre.fromJson(item)).toList(),
//       json["release_date"],
//       json["runtime"],
//     );
//   }
// }
}
