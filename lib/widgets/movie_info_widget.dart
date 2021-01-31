import 'package:flutter/material.dart';
import 'package:movie_app/bloc/movie_detail_cast.dart';
import 'package:movie_app/models/movie_detail.dart';

class MovieInfo extends StatefulWidget {
  final int movieId;
  MovieInfo({@required this.movieId});
  @override
  _MovieInfoState createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieDetailBloc.getMovieDetail(widget.movieId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    movieDetailBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieDetail>(
      stream: movieDetailBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildMovieDetailWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildMovieDetailWidget(MovieDetail detail) {
    //MovieDetail detail = data[widget.movieId];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "BUDGET",
                    style: TextStyle(
                        //color: Style.Colors.titleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    detail.budget.toString() + "\$",
                    style: TextStyle(
                        //color: Style.Colors.secondColor,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "DURATION",
                    style: TextStyle(
                        //color: Style.Colors.titleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(detail.runtime.toString() + "min",
                      style: TextStyle(
                          //color: Style.Colors.secondColor,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "RELEASE DATE",
                    style: TextStyle(
                        //color: Style.Colors.titleColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(detail.releaseDate,
                      style: TextStyle(
                          //color: Style.Colors.secondColor,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0))
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "GENRES",
                style: TextStyle(
                    //color: Style.Colors.titleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 50.0,
                padding: EdgeInsets.only(right: 10.0, top: 10.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: detail.genres.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            border:
                                Border.all(width: 1.0, color: Theme.of(context).textTheme.headline6.color)),
                        child: Text(
                          detail.genres[index].name,
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.4,
                              //color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
