import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/bloc/persons_bloc.dart';
import 'package:movie_app/models/person.dart';
import 'package:movie_app/models/person_response.dart';
import 'package:movie_app/screens/person_detail_screen.dart';

class Persons extends StatefulWidget {
  @override
  _PersonsState createState() => _PersonsState();
}

class _PersonsState extends State<Persons> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    personsBloc.getPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0),
          child: Text(
            "TRENDING PERSONS ON THIS WEEK",
            style: TextStyle(
                //color: Style.Colors.titleColor,
                fontWeight: FontWeight.w500,
                fontSize: 13.0),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        StreamBuilder(
          stream: personsBloc.personsSubject.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                height: 120.0,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).textTheme.headline6.color),
                  ),
                ),
              );
            } else {
              PersonResponse personResponse = snapshot.data;
              List<Person> persons = personResponse.persons;
              return persons.length == 0
                  ? Container(
                      height: 80.0,
                      child: Center(
                        child: Text("No One Trending persons on this Week"),
                      ),
                    )
                  : Container(
                      height: 120.0,
                      padding: EdgeInsets.only(left: 2.0),
                      margin: EdgeInsets.only(bottom: 20),
                      child: ListView.builder(
                        itemCount: persons.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(top: 10.0, right: 8.0),
                            width: 100.0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PersonDetailScreen(id: persons[index].id,),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  persons[index].profileImg == null
                                      ? Hero(
                                          tag: persons[index].id,
                                          child: Container(
                                            width: 70.0,
                                            height: 70.0,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                            child: Icon(
                                              FontAwesomeIcons.userAlt,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Hero(
                                          tag: persons[index].id,
                                          child: Container(
                                              width: 70.0,
                                              height: 70.0,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "https://image.tmdb.org/t/p/w300/" +
                                                            persons[index]
                                                                .profileImg)),
                                              )),
                                        ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      persons[index].name,
                                      maxLines: 2,
                                      style: TextStyle(
                                          height: 1.4,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.0,
                                  ),
                                  Text(
                                    "Trending for " + persons[index].known,
                                    maxLines: 2,
                                    style: TextStyle(
                                        height: 1.4,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
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
          },
        ),
      ],
    );
  }
}
