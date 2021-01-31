class Movie {
  int id;
  double popularity;
  String title;
  String backPoster;
  String poster;
  String overview;
  double rating;

  Movie(
      {this.id,
      this.popularity,
      this.title,
      this.backPoster,
      this.poster,
      this.overview,
      this.rating});

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        title = json["title"],
        backPoster = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"],
        rating = json["vote_average"].toDouble();
}

// Movie.fromJson(Map<String, dynamic> json){
//      id = json["id"];
//       popularity = json["popularity"];
//       title = json["title"];
//       backPoster = json["backdrop_path"];
//       poster = json["poster_path"];
//       overview = json["overview"];
//       rating = json["vote_average"].toDouble();
//      }

// factory Movie.fromJson(Map<String, dynamic> json) {
//   return Movie(
//     id: json["id"],
//     popularity: json["popularity"],
//     title: json["title"],
//     backPoster: json["backdrop_path"],
//     poster: json["poster_path"],
//     overview: json["overview"],
//     rating: json["vote_average"].toDouble(),
//   );
// }
