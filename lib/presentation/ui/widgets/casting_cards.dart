import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/data/models/models.dart';
import 'package:movies_app/presentation/controller/movies_controller.dart';
import 'package:movies_app/presentation/ui/widgets/cast_card.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  CastingCards({Key? key, required this.movieId}) : super(key: key);

  final int movieId;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final moviesController =
        Provider.of<MoviesController>(context, listen: false);

    return FutureBuilder(
      future: moviesController.fetchMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: const BoxConstraints(maxHeight: 150),
            height: 150,
            child: const CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        if (cast.isEmpty) {
          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: const Center(
              child: Column(
                children: [
                  Text(
                    '... Reparto ...',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: AssetImage('assets/no-data.png'),
                    height: 160,
                  ),
                ],
              ),
            ),
          );
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          width: double.infinity,
          height: 180,
          child: Scrollbar(
            thumbVisibility: true,
            controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: cast.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => CastCard(
                actor: cast[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
