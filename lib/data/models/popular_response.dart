import 'dart:convert';
import 'package:movies_app/data/models/models.dart';

class PorpularResponse {
  PorpularResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory PorpularResponse.fromJson(String str) =>
      PorpularResponse.fromMap(json.decode(str));

  factory PorpularResponse.fromMap(Map<String, dynamic> json) =>
      PorpularResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
