import 'http.dart';
import 'package:movies_app/data/models/models.dart';

class MovieDataSource {
  Future<List<Movie>> getOnDisplayMovies() async {
    try {
      final jsonData = await httpGet('3/movie/now_playing');

      final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
      final onDisplayMovies = nowPlayingResponse.results;

      return onDisplayMovies;
    } catch (e) {
      throw Exception(
          'Ocurrió un error al obtener las películas en cartelera: $e');
    }
  }

  Future<List<Movie>> getPopularMovies(int popularPage) async {
    try {
      final jsonData = await httpGet('3/movie/popular', popularPage);
      final popularResponse = PorpularResponse.fromJson(jsonData);

      final popularMoviesRes = popularResponse.results;

      return popularMoviesRes;
    } catch (e) {
      throw Exception(
          'Ocurrió un error al obtener las películas populares: $e');
    }
  }

  Future<List<Movie>> getMostQualifiedMovies(int mostQualifiedMoviePage) async {
    try {
      final jsonData =
          await httpGet('3/movie/top_rated', mostQualifiedMoviePage);

      final mostQualifiedResponse = PorpularResponse.fromJson(jsonData);

      final mostQualifiedMoviesRes = mostQualifiedResponse.results;

      return mostQualifiedMoviesRes;
    } catch (e) {
      throw Exception(
          'Ocurrió un error al obtener las películas mejor calificadas: $e');
    }
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    try {
      final jsonData = await httpGet('3/movie/$movieId/credits');
      final creditsResponse = CreditsResponse.fromJson(jsonData);

      return creditsResponse.cast;
    } catch (e) {
      throw Exception(
          'Ocurrió un error al obtener los actores de la pelicula: $e');
    }
  }
}
