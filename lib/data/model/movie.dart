import 'package:cinemax/constants/string_constants.dart';

class Movie {
  String id;
  String collectionId;
  String name;
  String genre;
  String pg;
  String storyline;
  String timeLength;
  String year;
  String rate;
  String category;
  String thumbnail;

  Movie(
      this.id,
      this.collectionId,
      this.name,
      this.genre,
      this.pg,
      this.storyline,
      this.timeLength,
      this.year,
      this.rate,
      this.category,
      this.thumbnail);

  factory Movie.withJson(Map<String, dynamic> jsonMapObject) {
    return Movie(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["name"],
      jsonMapObject["genre"],
      jsonMapObject["pg"],
      jsonMapObject["storyline"],
      jsonMapObject["time_length"].toString(),
      jsonMapObject["year"].toString(),
      jsonMapObject["rate"].toString(),
      jsonMapObject["category"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
    );
  }
}
