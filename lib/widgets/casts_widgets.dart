import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/bloc/cast_bloc.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/screens/person_detail_screen.dart';

class Casts extends StatefulWidget {
  final int movieId;
  Casts({@required this.movieId});

  @override
  _CastsState createState() => _CastsState();
}

class _CastsState extends State<Casts> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    castsBloc..getCasts(widget.movieId);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    castsBloc..drainStream();
    castsBloc..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "CASTS",
            style: TextStyle(
                //color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 15.0),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder<List<Cast>>(
          stream: castsBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildCastWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error);
            } else {
              return _buildLoadingWidget();
            }
          },
        )
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
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

  Widget _buildCastWidget(List<Cast> data) {
    List<Cast> casts = data;
    if (casts.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "No More Persons",
                  //style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else
      return Container(
        height: 140.0,
        padding: EdgeInsets.only(left: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: casts.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(top: 10.0, right: 8.0),
              width: 100.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PersonDetailScreen(id: casts[index].personId),
                    ),
                  );
                  print(casts[index].personId);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    casts[index].img == null
                        ? Hero(
                            tag: casts[index].id,
                            child: Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                //color: Style.Colors.secondColor
                                color: Theme.of(context).accentColor,
                              ),
                              child: Icon(
                                FontAwesomeIcons.userAlt,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          )
                        : Hero(
                            tag: casts[index].id,
                            child: Container(
                                width: 70.0,
                                height: 70.0,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w300/" +
                                              casts[index].img)),
                                )),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      casts[index].name,
                      maxLines: 2,
                      style: TextStyle(
                          height: 1.4,
                          //color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 9.0),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      casts[index].character,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.4,
                          //color: Style.Colors.titleColor,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 7.0),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
  }
}
