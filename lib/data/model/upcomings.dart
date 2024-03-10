import 'package:cinemax/constants/string_constants.dart';

class Upcomings {
  String id;
  String collectionId;
  String name;
  String releaseDate;
  String releaseMonth;
  String releaseYear;
  String synopsis;
  String thumbnail;
  String genre;

  Upcomings(
      this.id,
      this.collectionId,
      this.name,
      this.releaseDate,
      this.releaseMonth,
      this.releaseYear,
      this.synopsis,
      this.thumbnail,
      this.genre);

  factory Upcomings.withJson(Map<String, dynamic> jsonMapObject) {
    return Upcomings(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["name"],
      jsonMapObject["release_date"],
      jsonMapObject["release_month"],
      jsonMapObject["release_year"],
      jsonMapObject["synopsis"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
      jsonMapObject["genre"],
    );
  }
}
