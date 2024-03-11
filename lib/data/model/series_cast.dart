import 'package:cinemax/constants/string_constants.dart';

class SeriesCasts {
  String id;
  String collectionId;
  String name;
  String role;
  String movieId;
  String thumbnail;

  SeriesCasts(this.id, this.collectionId, this.name, this.role, this.movieId,
      this.thumbnail);

  factory SeriesCasts.withJson(Map<String, dynamic> jsonMapObject) {
    return SeriesCasts(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["name"],
      jsonMapObject["role"],
      jsonMapObject["series_id"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
    );
  }
}
