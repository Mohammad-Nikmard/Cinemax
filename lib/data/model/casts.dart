import 'package:cinemax/constants/string_constants.dart';

class Casts {
  String id;
  String collectionId;
  String name;
  String role;
  String movieId;
  String thumbnail;

  Casts(this.id, this.collectionId, this.name, this.role, this.movieId,
      this.thumbnail);

  factory Casts.withJson(Map<String, dynamic> jsonMapObject) {
    return Casts(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["name"],
      jsonMapObject["role"],
      jsonMapObject["movie_id"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
    );
  }
}
