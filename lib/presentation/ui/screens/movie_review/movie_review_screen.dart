import 'movie_app_bar.dart';
import 'overview.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/data/models/models.dart';
import 'package:movies_app/presentation/ui/screens/movie_review/poster_title.dart';
import 'package:movies_app/presentation/ui/widgets/widgets.dart';

class MovieReviewScreen extends StatefulWidget {
  const MovieReviewScreen({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  State<MovieReviewScreen> createState() => _MovieReviewScreenState();
}

class _MovieReviewScreenState extends State<MovieReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MovieAppBar(movie: widget.movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                PosterAndTitle(movie: widget.movie),
                Overview(movie: widget.movie),
                CastingCards(
                  movieId: widget.movie.id,
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.white10,
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
