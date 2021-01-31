import 'package:flutter/material.dart';
import 'package:movie_app/bloc/movies_byGenre_bloc.dart';
import 'package:movie_app/models/genre.dart';
import 'package:movie_app/widgets/movies_by_genre.dart';

class GenreList extends StatefulWidget {
  final List<Genre> genres;

  GenreList({@required this.genres});

  @override
  _GenreListState createState() => _GenreListState();
}

class _GenreListState extends State<GenreList> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: widget.genres.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        moviesByGenreBloc..drainStream();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 310.0,
        child: DefaultTabController(
          length: widget.genres.length,
          child: Scaffold(
            //backgroundColor: Style.Colors.mainColor,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Theme.of(context).accentColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3.0,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Theme.of(context).textTheme.headline6.color,
                  isScrollable: true,
                  tabs: widget.genres.map((Genre genre) {
                    return Container(
                        padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                        child: new Text(genre.name.toUpperCase(), style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        )));
                  }).toList(),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: widget.genres.map((Genre genre) {
                //return GenreMovies(genreId: genre.id,);
              return GenresMovies(genreId: genre.id);
              }).toList(),
            ),
          ),
        ));  }
}
