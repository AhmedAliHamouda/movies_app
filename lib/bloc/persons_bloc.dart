import 'package:movie_app/models/person_response.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class PersonsBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<PersonResponse> _subject =
      BehaviorSubject<PersonResponse>();

  getPersons() async {
    PersonResponse response = await _repository.getPersonsMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get personsSubject => _subject;
}

final personsBloc = PersonsBloc();
