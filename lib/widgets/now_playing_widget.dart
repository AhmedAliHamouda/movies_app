import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/bloc/movie_videos_bloc.dart';
import 'package:movie_app/bloc/now_playing_bloc.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_response.dart';
import 'package:movie_app/models/video.dart';
import 'package:movie_app/screens/video_player_screen.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviesNowPlaying extends StatefulWidget {
  @override
  _MoviesNowPlayingState createState() => _MoviesNowPlayingState();
}

class _MoviesNowPlayingState extends State<MoviesNowPlaying> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowPlayingMoviesBloc.getMoviesNowPlaying();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: nowPlayingMoviesBloc.moviesNowPlayingSubject.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 220.0,
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
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("No More Movies"),
                        ],
                      )
                    ],
                  ),
                )
              : Container(
                  height: 220.0,
                  child: PageIndicatorContainer(
                    align: IndicatorAlign.bottom,
                    indicatorSpace: 8.0,
                    padding: EdgeInsets.all(5.0),
                    indicatorColor: Colors.grey,
                    indicatorSelectorColor: Theme.of(context).accentColor,
                    shape: IndicatorShape.circle(size: 7.0),
                    length: movies.take(5).length,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.take(5).length,
                      itemBuilder: (context, index) {
                        final movieId = movies[index].id;
                        movieVideosBloc.getMovieVideos(movieId);
                        return Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 220,
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original/${movies[index].backPoster}',
                                fit: BoxFit.cover,
                              ),
                              // Image.network(
                              //   'https://image.tmdb.org/t/p/original/${movies[index].backPoster}',
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withOpacity(1.0),
                                    Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withOpacity(0.0),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: [
                                    0.0,
                                    0.9,
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: StreamBuilder(
                                stream: movieVideosBloc.subject.stream,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container();
                                  } else {
                                    List<Video> movieVideos = snapshot.data;
                                    return movieVideos.length == 0
                                        ? Container()
                                        : IconButton(
                                            icon: Icon(
                                              FontAwesomeIcons.playCircle,
                                              size: 50,
                                              color: Colors.amber,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      VideoPlayerScreen(
                                                    controller:
                                                        YoutubePlayerController(
                                                      initialVideoId:
                                                          movieVideos[0].key,
                                                      flags: YoutubePlayerFlags(
                                                        autoPlay: true,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                  } //else
                                }, //builder Stream
                              ),
                              // child: IconButton(
                              //   icon: Icon(FontAwesomeIcons.playCircle,size: 50,color: Theme.of(context).accentColor,),
                              //   onPressed: (){},
                              // ),
                            ),
                            Positioned(
                              bottom: 30,
                              child: Container(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                width: 220,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movies[index].title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
        }
      },
    );
  }
}
