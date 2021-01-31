import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieDetail> _subject =
  BehaviorSubject<MovieDetail>();

  getMovieDetail(int id) async {
    MovieDetail response = await _repository.getMovieDetail(id);
    _subject.sink.add(response);
  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieDetail> get subject => _subject;

}
final movieDetailBloc = MovieDetailBloc();