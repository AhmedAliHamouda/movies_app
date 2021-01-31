import 'package:flutter/material.dart';
import 'package:movie_app/models/person_detail.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class PersonDetailBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<PersonDetail> _subject =
  BehaviorSubject<PersonDetail>();

getPersonDetail(int id) async {
    PersonDetail response = await _repository.getPersonDetail(id);
    _subject.sink.add(response);
  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<PersonDetail> get subject => _subject;

}
final personDetailBloc = PersonDetailBloc();