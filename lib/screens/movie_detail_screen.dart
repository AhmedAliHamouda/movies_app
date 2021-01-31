import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/bloc/movie_videos_bloc.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/video.dart';
import 'package:movie_app/screens/video_player_screen.dart';
import 'package:movie_app/widgets/casts_widgets.dart';
import 'package:movie_app/widgets/movie_info_widget.dart';
import 'package:movie_app/widgets/similar_movies_widget.dart';
import 'package:sliver_fab/sliver_fab.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  MovieDetailScreen({this.movie});
  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieVideosBloc.getMovieVideos(widget.movie.id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    movieVideosBloc.drainStream();
    //movieVideosBloc.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return SliverFab(
            floatingPosition: FloatingPosition(right: 20.0),
            floatingWidget: StreamBuilder(
              stream: movieVideosBloc.subject.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  List<Video> movieVideos = snapshot.data;
                  return movieVideos.length == 0
                      ? Container()
                      : FloatingActionButton(
                          backgroundColor: Theme.of(context).accentColor,
                          child: Icon(Icons.play_arrow),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoPlayerScreen(
                                  controller: YoutubePlayerController(
                                    initialVideoId: movieVideos[0].key,
                                    flags: YoutubePlayerFlags(autoPlay: true,),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                } //else
              }, //builder Stream
            ),
            expandedHeight: 250.0,
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 250.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Container(
                    child: Text(
                      widget.movie.title.length > 40
                          ? widget.movie.title.substring(0, 37) + '...'
                          : widget.movie.title,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  background: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/original/${widget.movie.backPoster}'),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor.withOpacity(0.2)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [
                                0.1,
                                0.9
                              ],
                              colors: [
                                Theme.of(context)
                                    .scaffoldBackgroundColor.withOpacity(0.8),
                                Theme.of(context)
                                    .scaffoldBackgroundColor.withOpacity(0.0)
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(0.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.movie.rating.toString(),
                              style: TextStyle(
                                  //color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            RatingBar.builder(
                              itemSize: 13.0,
                              initialRating: widget.movie.rating / 2,
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
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                        child: Text(
                          "OVERVIEW",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16.0),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.movie.overview,
                          style: TextStyle(
                              //color: Colors.white,
                              fontSize: 13.0,
                              height: 1.5),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      MovieInfo(
                        movieId: widget.movie.id,
                      ),
                      Casts(movieId: widget.movie.id),
                      SimilarMovies(
                        movieId: widget.movie.id,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }, //Builder Widget
      ),
    );
  }
}
