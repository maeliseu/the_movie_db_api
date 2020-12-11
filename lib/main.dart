import 'package:flutter/material.dart';

import 'package:the_movie_db_api/service/movie_service.dart';
import 'package:the_movie_db_api/widigets/custom_listview.dart';

import 'model/movie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = "";
  MovieService _service = MovieService();
  List movies = [];
  int itemCount = 0;
  Icon icon = Icon(Icons.search);
  Widget searchBar = Text('The MovieDB');

  @override
  void initState() {
    super.initState();
    _service.getMovies(title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: [
          IconButton(
              icon: icon,
              onPressed: () {
                setState(() {
                  if (this.icon.icon == Icons.search) {
                    this.icon = Icon(Icons.cancel);
                    this.searchBar = TextField(
                      onSubmitted: (text) {
                        setState(() {
                          title = text;
                        });
                      },
                      textInputAction: TextInputAction.search,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    );
                  } else {
                    setState(() {
                      this.icon = Icon(Icons.search);
                      this.searchBar = Text('The MovieDB');
                      title = "";
                    });
                  }
                });
              })
        ],
      ),
      body: _listView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _listView() {
    Future<List<Movie>> futureGetMovies = _service.getMovies(title);
    return FutureBuilder(
      future: futureGetMovies,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
              child: Text("Nao foi possivel carregar os dados... =("));
        }
        return CustomListView(snapshot.data);
      },
    );
  }
}
