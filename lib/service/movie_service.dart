import '../helper/http_helper.dart';
import '../model/movie.dart';

class MovieService {
  final helper = HttpHelper();

  Future<List<Movie>> getMovies(String title) async {
    if (title.isEmpty) {
      return helper.getUpcoming();
    } else {
      print(title);
      return helper.findMovies(title);
    }
  }
}
