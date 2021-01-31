import 'package:flutter/material.dart';
import 'package:movie_app/bloc/genres_bloc.dart';
import 'package:movie_app/models/genre.dart';
import 'package:movie_app/models/genre_response.dart';
import 'package:movie_app/widgets/genres_list_widget.dart';

class Genres extends StatefulWidget {
  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genresBloc.getGenresMovies();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: genresBloc.genresSubject.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: 300.0,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).textTheme.headline6.color),
                ),
              ),
            );
          } else {
            GenreResponse genreResponse = snapshot.data;
            List<Genre> genres = genreResponse.genres;
            return genres.length == 0
                ? Center(
                    child: Text('NO genres'),
                  )
                : GenreList(genres: genres);
          }
        } //builder
    );
  }
}
