import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movies_app/data/data_source/movie_data_source.dart';
import 'package:movies_app/data/models/models.dart';

class MoviesController extends ChangeNotifier {
  final MovieDataSource movieDataSource = MovieDataSource();

  bool isLoadingPopular = false;
  bool isLoadingMovieTerror = false;
  bool isLoadingMovieAnimation = false;
  bool isLoadingMostQualified = false;

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> popularMoviesAnimation = [];
  List<Movie> popularMoviesTerror = [];
  List<Movie> mostQualifiedMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 1;
  int _animationMoviePage = 0;
  int _terrorMoviePage = 0;
  int _mostQualifiedMoviePage = 0;

  var logger = Logger();

  MoviesController() {
    logger.i('MoviesController inializado');
    fetchOnDisplayMovies();
    fetchPopularMovies();
    fetchPopularMoviesAnimation();
    fetchPopularMoviesTerror();
    fetchMostQualifiedMovies();
  }

  Future<void> fetchOnDisplayMovies() async {
    try {
      onDisplayMovies = await movieDataSource.getOnDisplayMovies();
      notifyListeners();
    } catch (e) {
      logger.e('Error al obtener las películas en cartelera: $e');
    }
  }

  Future<void> fetchPopularMovies() async {
    isLoadingPopular = true;
    notifyListeners();

    _popularPage++;

    try {
      final popularMoviesRes =
          await movieDataSource.getPopularMovies(_popularPage);

      popularMovies = [...popularMovies, ...popularMoviesRes];

      isLoadingPopular = false;
      notifyListeners();
    } catch (e) {
      logger.e('Error al obtener las películas en cartelera: $e');
    } finally {
      isLoadingPopular = false;
      notifyListeners();
    }
  }

  Future<void> fetchPopularMoviesAnimation() async {
    isLoadingMovieAnimation = true;
    notifyListeners();

    _animationMoviePage++;

    try {
      final popularMoviesAnimationRes =
          await movieDataSource.getPopularMovies(_animationMoviePage);

      popularMoviesAnimation = [
        ...popularMoviesAnimation,
        ...popularMoviesAnimationRes
      ].where((movie) => movie.genreIds.contains(16)).toList();

      if (popularMoviesAnimation.length <= 5) {
        fetchPopularMoviesAnimation();
      }

      isLoadingMovieAnimation = false;
      notifyListeners();
    } catch (e) {
      logger.e('Error al obtener las películas populares animadas: $e');
    } finally {
      isLoadingMovieAnimation = false;
      notifyListeners();
    }
  }

  Future<void> fetchPopularMoviesTerror() async {
    isLoadingMovieTerror = true;
    notifyListeners();

    _terrorMoviePage++;

    try {
      final popularMoviesTerrorRes =
          await movieDataSource.getPopularMovies(_terrorMoviePage);

      popularMoviesTerror = [...popularMoviesTerror, ...popularMoviesTerrorRes]
          .where((movie) => movie.genreIds.contains(27))
          .toList();

      if (popularMoviesTerror.length <= 5) {
        logger.w('Rellenando');
        fetchPopularMoviesTerror();
      }

      isLoadingMovieTerror = false;
      notifyListeners();
    } catch (e) {
      logger.e('Error al obtener las películas populares de terror: $e');
    } finally {
      isLoadingMovieTerror = false;
      notifyListeners();
    }
  }

  Future<void> fetchMostQualifiedMovies() async {
    isLoadingMostQualified = true;
    notifyListeners();

    _mostQualifiedMoviePage++;

    try {
      final mostQualifiedMoviesRes =
          await movieDataSource.getMostQualifiedMovies(_mostQualifiedMoviePage);

      mostQualifiedMovies = [...mostQualifiedMovies, ...mostQualifiedMoviesRes];

      isLoadingMostQualified = false;
      notifyListeners();
    } catch (e) {
      logger.e('Error al obtener las películas mejor calificadas: $e');
    } finally {
      isLoadingMostQualified = false;
      notifyListeners();
    }
  }

  Future<List<Cast>> fetchMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    try {
      final movieCastRes = await movieDataSource.getMovieCast(movieId);

      moviesCast[movieId] = movieCastRes;
      return movieCastRes;
    } catch (e) {
      logger.e('Error al obtener los actores de la pelicula: $e');
      rethrow;
    }
  }
}
