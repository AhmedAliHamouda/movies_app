import 'package:movie_app/models/movie_response.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchMoviesBloc {
  final MovieRepository _movieRepository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
  BehaviorSubject<MovieResponse>();

  getSearchMovies(String searchQuery) async {
    MovieResponse movieResponse = await _movieRepository.getSearchMovies(searchQuery);
    _subject.sink.add(movieResponse);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get searchMoviesSubject {
    return _subject;
  }
}

final searchMoviesBloc = SearchMoviesBloc();