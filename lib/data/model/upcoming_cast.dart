import 'package:cinemax/constants/string_constants.dart';

class UpcomingsCasts {
  String id;
  String collectionId;
  String name;
  String role;
  String movieId;
  String thumbnail;

  UpcomingsCasts(this.id, this.collectionId, this.name, this.role, this.movieId,
      this.thumbnail);

  factory UpcomingsCasts.withJson(Map<String, dynamic> jsonMapObject) {
    return UpcomingsCasts(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["name"],
      jsonMapObject["role"],
      jsonMapObject["upcoming_id"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
    );
  }
}
