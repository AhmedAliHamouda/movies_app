import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/bloc/person_detail_bloc.dart';
import 'package:movie_app/bloc/person_movies_bloc.dart';
import 'package:movie_app/models/person_detail.dart';
import 'package:movie_app/widgets/person_movies_widget.dart';

class PersonDetailWidget extends StatefulWidget {
  final int movieId;
  final PersonDetail personDetail;


  PersonDetailWidget({@required this.movieId,@required this.personDetail});

  @override
  _PersonDetailWidgetState createState() => _PersonDetailWidgetState();
}

class _PersonDetailWidgetState extends State<PersonDetailWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    personMoviesBloc.getPersonMovies(widget.movieId);
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            color: Colors.black54,
          ),
          margin: EdgeInsets.only(top: 130,),
          padding:
          EdgeInsets.only(top: 8,bottom: 8,left: 40,right: 10),
          child: Text(
            widget.personDetail.name,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 25,color: Colors.white),
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50, left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://image.tmdb.org/t/p/w300/' +
                        widget.personDetail.profileImg),
                radius: 60,
              ),
              Column(
                children: [
                  Text(
                    'POPULARITY',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.personDetail.popularity.toString() + ' K',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'DATE OF BIRTH',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.personDetail.birthday,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'DATE OF DEATH',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.personDetail.deathDay==null ?'----------------------':widget.personDetail.deathDay,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Place OF BIRTH',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.personDetail.placeOfBirth,
                style: TextStyle(fontSize: 15,letterSpacing: 1,wordSpacing: 2),
              ),
            ],
          ),

        ),
        Container(
          margin: EdgeInsets.only(left: 20,right: 5,top: 10,bottom: 10),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BIOGRAPHY',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.personDetail.biography,
                style: TextStyle(fontSize: 13,wordSpacing: 1,height: 1.2,fontStyle: FontStyle.normal),
              ),
            ],
          ),
        ),
        PersonMoviesWidget(id: widget.movieId,),

      ],
    );





    // return StreamBuilder<PersonDetail>(
    //   stream: personDetailBloc.subject.stream,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return _buildPersonDetailWidget(snapshot.data);
    //     } else if (snapshot.hasError) {
    //       return _buildErrorWidget(snapshot.error);
    //     } else {
    //       return _buildLoadingWidget();
    //     }
    //   },
    // );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
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

  Widget _buildPersonDetailWidget(PersonDetail personDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 100, left: 40),
          child: Text(
            personDetail.name,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            maxLines: 1,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 100, left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://image.tmdb.org/t/p/w300/' +
                        personDetail.profileImg),
                radius: 60,
              ),
              Column(
                children: [
                  Text(
                    'POPULARITY',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    personDetail.popularity.toString() + ' K',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'DATE OF BIRTH',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    personDetail.birthday,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'DATE OF DEATH',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    personDetail.deathDay==null ?'----------------------':personDetail.deathDay,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Place OF BIRTH',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                personDetail.placeOfBirth,
                style: TextStyle(fontSize: 15,letterSpacing: 1,wordSpacing: 2),
              ),
            ],
          ),

        ),
        Container(
          margin: EdgeInsets.only(left: 20,right: 5,top: 10,bottom: 10),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BIOGRAPHY',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.grey),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                personDetail.biography,
                style: TextStyle(fontSize: 13,wordSpacing: 1,height: 1.2,fontStyle: FontStyle.normal),
              ),
            ],
          ),
        ),

        Container(
          height: 200,
          child: Center(child: Text('hello')),
        ),
        PersonMoviesWidget(id: widget.movieId,),
      ],
    );
  }
}
