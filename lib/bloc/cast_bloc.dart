import 'package:flutter/material.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class CastsBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<List<Cast>> _subject =
  BehaviorSubject<List<Cast>>();

  getCasts(int id) async {
    List<Cast> response = await _repository.getCasts(id);
    _subject.sink.add(response);
  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<List<Cast>> get subject => _subject;

}
final castsBloc = CastsBloc();