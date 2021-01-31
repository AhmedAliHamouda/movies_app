
import 'package:movie_app/models/person_movies_response.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class PersonMoviesBloc {
  final MovieRepository _movieRepository = MovieRepository();
  final BehaviorSubject<PersonMovieResponse> _subject =
  BehaviorSubject<PersonMovieResponse>();

  getPersonMovies(int id) async {
    PersonMovieResponse movieResponse = await _movieRepository.getPersonMovies(id);
    _subject.sink.add(movieResponse);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonMovieResponse> get personMoviesSubject {
    return _subject;
  }
}

final personMoviesBloc = PersonMoviesBloc();