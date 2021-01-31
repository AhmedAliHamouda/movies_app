import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/search_movies_screen.dart';
import 'package:movie_app/theme.dart';
import 'package:movie_app/widgets/genres_widget.dart';
import 'package:movie_app/widgets/now_playing_widget.dart';
import 'package:movie_app/widgets/persons_widget.dart';
import 'package:movie_app/widgets/top_movies.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  bool _isSearching = false;
  String searchNameMovie;

  Widget searchBar() {
    return TextField(
      textInputAction: TextInputAction.done,
      style: TextStyle(fontSize: 18, color: Colors.white),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Search....',
        hintStyle: TextStyle(fontSize: 18, color: Colors.white70),
      ),
      onSubmitted: (value) {
        print(value);
        if(value!=null&& value.isNotEmpty){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchMoviesScreen(searchText: value),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? searchBar() : Text('Movies App'),
        centerTitle: _isSearching ? false : true,
        leading: themeChange.darkMode
            ? IconButton(
                icon: Icon(
                  EvaIcons.sun,
                  size: 25,
                ),
                onPressed: () async {
                  themeChange.toggleChangeTheme();
                })
            : IconButton(
                icon: Icon(
                  Icons.nights_stay,
                  size: 25,
                ),
                onPressed: () {
                  themeChange.toggleChangeTheme();
                }),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: _isSearching
                ? IconButton(
                    icon: Icon(EvaIcons.close),
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(EvaIcons.searchOutline),
                    onPressed: () {
                      setState(() {
                        _isSearching = true;
                      });
                    },
                  ),
          ),
        ],
      ),
      body: ListView(
        children: [
          MoviesNowPlaying(),
          Genres(),
          Persons(),
          TopMovies(),
        ],
      ),
    );
  }
}
