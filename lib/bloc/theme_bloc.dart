
import 'package:rxdart/rxdart.dart';

class ThemeBloc {
  // final _themeStreamController = StreamController<bool>();
  // get changeTheTheme => _themeStreamController.sink.add;
  // get darkThemeIsEnabled => _themeStreamController.stream;
  // dispose(){
  //   _themeStreamController.close();
  // }


  final BehaviorSubject<bool> _subject =
  BehaviorSubject<bool>();
  get changeTheThemeData => _subject.sink.add;
  dispose() {
    _subject.close();
  }
  BehaviorSubject<bool> get darkThemeIsEnabled => _subject;

}