import 'package:flutter/material.dart';
import 'package:movies_app/data/models/models.dart';

class Overview extends StatelessWidget {
  const Overview({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      child: Column(
        children: [
          Text(
            movie.overview,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Container(width: double.infinity, height: 1, color: Colors.white),
          const SizedBox(height: 6),
          Text(
            'Reparto / Actores',
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }
}
