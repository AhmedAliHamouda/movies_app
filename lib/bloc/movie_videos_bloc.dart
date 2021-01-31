import 'package:flutter/material.dart';
import 'package:movie_app/models/video.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieVideosBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<List<Video>> _subject = BehaviorSubject<List<Video>>();

  getMovieVideos(int id) async {
    List<Video> response = await _repository.getMovieVideos(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<List<Video>> get subject => _subject;
}

final movieVideosBloc = MovieVideosBloc();
