import 'dart:convert';
import 'package:movies_app/data/models/models.dart';

class NowPlayingResponse {
  NowPlayingResponse({
    required this.page,
    required this.results,
  });

  int page;
  List<Movie> results;

  factory NowPlayingResponse.fromJson(String str) =>
      NowPlayingResponse.fromMap(json.decode(str));

  factory NowPlayingResponse.fromMap(Map<String, dynamic> json) =>
      NowPlayingResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
      );
}
