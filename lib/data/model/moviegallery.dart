import 'package:cinemax/constants/string_constants.dart';

class Moviesgallery {
  String id;
  String collectionId;
  String movieId;
  String thumbnail;

  Moviesgallery(this.id, this.collectionId, this.movieId, this.thumbnail);

  factory Moviesgallery.withJson(Map<String, dynamic> jsonMapObject) {
    return Moviesgallery(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["movie_id"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
    );
  }
}
