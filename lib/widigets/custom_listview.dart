import 'package:flutter/material.dart';

import '../model/movie.dart';
import '../movie_detail.dart';

class CustomListView extends StatelessWidget {
  final List<Movie> movies;
  const CustomListView(this.movies);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final url =
              'https://image.tmdb.org/t/p/w500/${movies[index].posterPath}';

          return Card(
            color: Colors.white,
            elevation: 4,
            child: ListTile(
              title: Text(movies[index].title),
              subtitle: Text(
                  'Lançamento: ${movies[index].releaseDate} - Média: ${movies[index].voteAverage}'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(url),
              ),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => MovieDetail(movies[index]));
                Navigator.push(context, route);
              },
            ),
          );
        });
  }
}
