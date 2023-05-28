import 'package:flutter/material.dart';
import 'package:movies_app/data/models/models.dart';
import 'package:movies_app/presentation/ui/screens/movie_review/movie_review_screen.dart';

// ignore: must_be_immutable
class MovieSlider extends StatefulWidget {
  MovieSlider({
    Key? key,
    required this.movies,
    this.title,
    required this.onNextPage,
    required this.isLoading,
  }) : super(key: key);

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;
  bool isLoading;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      // color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(widget.title!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Scrollbar(
                  child: SizedBox(
                    height: 240,
                    child: ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.movies.length,
                      itemBuilder: (_, int index) => _MoviePoster(
                        movie: widget.movies[index],
                        heroId:
                            '${widget.title}-$index-${widget.movies[index].id}',
                      ),
                    ),
                  ),
                ),
              ),
              widget.isLoading
                  ? const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 58, vertical: 42),
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({Key? key, required this.movie, required this.heroId})
      : super(key: key);

  final Movie movie;
  final String heroId;

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;

    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieReviewScreen(movie: movie),
                ),
              );
            },
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
