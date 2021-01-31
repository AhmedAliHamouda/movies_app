import 'package:flutter/material.dart';
import 'package:movie_app/models/person_images.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class PersonImagesBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<List<PersonImages>> _subject =
  BehaviorSubject<List<PersonImages>>();

  getPersonImages(int id) async {
    List<PersonImages> response = await _repository.getPersonImage(id);
    _subject.sink.add(response);
  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<List<PersonImages>> get subject => _subject;

}
final personImagesBloc = PersonImagesBloc();