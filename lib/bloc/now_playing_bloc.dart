import 'package:movie_app/models/movie_response.dart';
import 'package:movie_app/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
  BehaviorSubject<MovieResponse>();

  getMoviesNowPlaying() async {
    MovieResponse response = await _repository.getPlayingMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get moviesNowPlayingSubject => _subject;

}
final nowPlayingMoviesBloc = NowPlayingBloc();