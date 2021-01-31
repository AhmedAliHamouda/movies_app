import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/models/movie.dart';

class MoviesGenre extends StatefulWidget {
  final List<Movie> movies;

  MoviesGenre({@required this.movies});

  @override
  _MoviesGenreState createState() => _MoviesGenreState();
}

class _MoviesGenreState extends State<MoviesGenre> {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 270.0,
      padding: EdgeInsets.only(left: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
            child: InkWell(
              onTap: () {
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.movies[index].poster == null
                      ? Hero(
                          tag: widget.movies[index].id,
                          child: Container(
                            width: 120.0,
                            height: 180.0,
                            decoration: new BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  EvaIcons.filmOutline,
                                  color: Colors.white,
                                  size: 60.0,
                                )
                              ],
                            ),
                          ),
                        )
                      : Hero(
                          tag: widget.movies[index].id,
                          child: Container(
                              width: 120.0,
                              height: 180.0,
                              decoration: new BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2.0)),
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w200/" +
                                            widget.movies[index].poster)),
                              )),
                        ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      widget.movies[index].title,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.white,
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
                        widget.movies[index].rating.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      RatingBar.builder(
                        itemSize: 8.0,
                        initialRating: widget.movies[index].rating / 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
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
}
