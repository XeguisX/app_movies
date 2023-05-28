import 'package:flutter/material.dart';
import 'package:movies_app/presentation/controller/movies_controller.dart';
import 'package:movies_app/presentation/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesController = Provider.of<MoviesController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 4),
            //
            CardSwiper(movies: moviesController.onDisplayMovies),
            //
            MovieSlider(
              movies: moviesController.popularMovies,
              title: 'Populares',
              onNextPage: () => moviesController.fetchPopularMovies(),
              isLoading: moviesController.isLoadingPopular,
            ),
            //
            MovieSlider(
              movies: moviesController.popularMoviesTerror,
              title: 'Terror',
              onNextPage: () => moviesController.fetchPopularMoviesTerror(),
              isLoading: moviesController.isLoadingMovieTerror,
            ),
            //
            MovieSlider(
              movies: moviesController.popularMoviesAnimation,
              title: 'Animación',
              onNextPage: () => moviesController.fetchPopularMoviesAnimation(),
              isLoading: moviesController.isLoadingMovieAnimation,
            ),
            //
            MovieSlider(
              movies: moviesController.mostQualifiedMovies,
              title: 'Mejor Calificadas',
              onNextPage: () => moviesController.fetchMostQualifiedMovies(),
              isLoading: moviesController.isLoadingMostQualified,
            ),
            //
          ],
        ),
      ),
    );
  }
}
