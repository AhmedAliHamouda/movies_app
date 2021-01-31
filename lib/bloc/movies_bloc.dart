import 'package:movie_app/models/movie_response.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final MovieRepository _movieRepository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getPopularMovies() async {
    MovieResponse movieResponse = await _movieRepository.getPopularMovies();
    _subject.sink.add(movieResponse);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get moviesSubject {
    return _subject;
  }
}

final moviesBloc = MoviesBloc();
