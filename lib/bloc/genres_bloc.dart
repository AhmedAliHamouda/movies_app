import 'package:movie_app/models/genre_response.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class GenresBloc {
  final MovieRepository _movieRepository = MovieRepository();
  final BehaviorSubject<GenreResponse> _subject =
      BehaviorSubject<GenreResponse>();

  getGenresMovies() async {
    GenreResponse genresResponse = await _movieRepository.getGenresMovies();
    _subject.sink.add(genresResponse);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get genresSubject {
    return _subject;
  }
}

final genresBloc = GenresBloc();
