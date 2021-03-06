import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/movies_byGenre_bloc.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_response.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';

class GenresMovies extends StatefulWidget {
  final int genreId;
  GenresMovies({@required this.genreId});
  @override
  _GenresMoviesState createState() => _GenresMoviesState();
}

class _GenresMoviesState extends State<GenresMovies> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesByGenreBloc..getMoviesByGenre(widget.genreId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: moviesByGenreBloc.moviesByGenreSubject.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: 270.0,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).textTheme.headline6.color),
                ),
              ),
            );
          } else {
            MovieResponse moviesResponse = snapshot.data;
            List<Movie> movies = moviesResponse.movies;
            return movies.length == 0
                ? Container(
                    height: 270.0,
                    child: Center(
                      child: Text('NO genres'),
                    ),
                  )
                : Container(
                    height: 270.0,
                    padding: EdgeInsets.only(left: 10.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, right: 15.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailScreen(movie: movies[index]),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                movies[index].poster == null
                                    ? Container(
                                        width: 120.0,
                                        height: 180.0,
                                        decoration: new BoxDecoration(
                                          color: Theme.of(context).accentColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2.0)),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              EvaIcons.filmOutline,
                                              //color: Colors.white,
                                              size: 60.0,
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: 120.0,
                                        height: 180.0,
                                        decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2.0)),
                                          shape: BoxShape.rectangle,
                                          image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "https://image.tmdb.org/t/p/w200/" +
                                                      movies[index].poster)),
                                        ),
                                      ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    movies[index].title,
                                    maxLines: 2,
                                    style: TextStyle(
                                        height: 1.4,
                                        //color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.0),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      movies[index].rating.toString(),
                                      style: TextStyle(
                                          //color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    RatingBar.builder(
                                      itemSize: 9.0,
                                      initialRating: movies[index].rating / 2,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                      itemBuilder: (context, _) => Icon(
                                        EvaIcons.star,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
          }
        } //builder
        );
  }
}
