import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/search_movies_bloc.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_response.dart';

import 'movie_detail_screen.dart';

class SearchMoviesScreen extends StatefulWidget {
  final String searchText;
  SearchMoviesScreen({@required this.searchText});

  @override
  _SearchMoviesScreenState createState() => _SearchMoviesScreenState();
}

class _SearchMoviesScreenState extends State<SearchMoviesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchMoviesBloc.getSearchMovies(widget.searchText);
  }

  @override
  Widget build(BuildContext context) {
    final appBarForm= AppBar(
      title: Text(widget.searchText),
    );
    return Scaffold(
      appBar:appBarForm,
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StreamBuilder(
              stream: searchMoviesBloc.searchMoviesSubject.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: (MediaQuery.of(context).size.height - appBarForm.preferredSize.height)*0.95,
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
                    height: (MediaQuery.of(context).size.height - appBarForm.preferredSize.height)*0.95,
                          child: Center(
                            child: Text('No Movies'),
                          ),
                        )
                      : Container(
                          height: (MediaQuery.of(context).size.height - appBarForm.preferredSize.height)*0.95,
                          // padding: EdgeInsets.symmetric(
                          //     horizontal: 5.0, vertical: 3.0),
                          // margin: EdgeInsets.symmetric(
                          //     horizontal: 5, vertical: 10.0),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 0.53,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 2,
                            ),
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailScreen(
                                          movie: movies[index]),
                                    ),
                                  );
                                },
                                child: Column(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    movies[index].poster == null
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            height: 280.0,
                                            decoration: new BoxDecoration(
                                              color:
                                                  Theme.of(context).accentColor,
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            height: 280.0,
                                            decoration: new BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2.0)),
                                              shape: BoxShape.rectangle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      "https://image.tmdb.org/t/p/w200/" +
                                                          movies[index]
                                                              .poster)),
                                            ),
                                          ),
                                    SizedBox(height: 5.0,),
                                    Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.45,
                                      child: Text(
                                        movies[index].title,
                                        maxLines: 2,
                                        style: TextStyle(
                                            height: 1.4,
                                            //color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                    SizedBox(height: 5.0,),
                                    Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.45,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            movies[index].rating.toString(),
                                            style: TextStyle(
                                                //color: Colors.white,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          RatingBar.builder(
                                            itemSize: 14.0,
                                            initialRating:
                                                movies[index].rating / 2,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 2.0),
                                            itemBuilder: (context, _) => Icon(
                                              EvaIcons.star,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                }
              } //builder
              ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
