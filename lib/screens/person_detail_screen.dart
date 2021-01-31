import 'package:flutter/material.dart';
import 'package:movie_app/bloc/person_detail_bloc.dart';
import 'package:movie_app/bloc/person_images_bloc.dart';
import 'package:movie_app/models/person_detail.dart';
import 'package:movie_app/models/person_images.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:movie_app/widgets/person_detail_widget.dart';
import 'package:shape_of_view/shape_of_view.dart';

class PersonDetailScreen extends StatefulWidget {
  final int id;

  PersonDetailScreen({@required this.id});
  @override
  _PersonDetailScreenState createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    personDetailBloc.getPersonDetail(widget.id);
    personImagesBloc.getPersonImages(widget.id);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    personDetailBloc.drainStream();

    //personDetailBloc.dispose();
    super.dispose();
  }

  void getData() async {
    List<PersonImages> test = await MovieRepository().getPersonImage(widget.id);
    print('this or Test: ${test[1].profileImg}');
    print('this or Test: ${test[1].height}');
    print('this or Test: ${test[1].width}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<PersonDetail>(
        stream: personDetailBloc.subject.stream,
        builder: (context, AsyncSnapshot<PersonDetail> snapshot) {
          if (snapshot.hasData) {
            return _buildPersonDetailWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        },
      ),

      // body: SingleChildScrollView(
      //   child: Stack(
      //     children: [
      //       ShapeOfView(
      //         elevation: 4,
      //         height: 300,
      //         shape: DiagonalShape(
      //           position: DiagonalPosition.Bottom,
      //           direction: DiagonalDirection.Left,
      //           angle: DiagonalAngle.deg(angle: 15),
      //         ),
      //         child: Container(color: Colors.amber,),
      //       ),
      //       PersonDetailWidget(movieId: widget.id,),
      //     ],
      //   ),
      // ),
    );
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
    return SingleChildScrollView(
      child: Stack(
        children: [
          StreamBuilder(
              stream: personImagesBloc.subject.stream,
              builder: (context, snapshot) {
                List<PersonImages> _personImages = snapshot.data;
                return ShapeOfView(
                  elevation: 4,
                  height: 300,
                  shape: DiagonalShape(
                    position: DiagonalPosition.Bottom,
                    direction: DiagonalDirection.Left,
                    angle: DiagonalAngle.deg(angle: 15),
                  ),
                  child: snapshot.hasData
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          child: _personImages?.length == 1
                              ? Image.network(
                                  'https://image.tmdb.org/t/p/w500/' +
                                      _personImages[0].profileImg,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  'https://image.tmdb.org/t/p/w500/' +
                                      _personImages[1].profileImg,
                                  fit: BoxFit.fill,
                                ),
                        )
                      : Container(
                          color: Colors.black54,
                        ),
                );
              }),
          PersonDetailWidget(
            movieId: widget.id,
            personDetail: personDetail,
          ),
          Positioned(
              top: 30,
              left: 2,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 25,
                color: Colors.white,
                onPressed: (){
                  Navigator.pop(context);
                },
              )),
        ],
      ),
    );
  }
}
