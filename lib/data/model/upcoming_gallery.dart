import 'package:cinemax/constants/string_constants.dart';

class UpcomingGallery {
  String id;
  String collectionId;
  String upcoimngId;
  String thumbnail;

  UpcomingGallery(this.id, this.collectionId, this.upcoimngId, this.thumbnail);

  factory UpcomingGallery.withJson(Map<String, dynamic> jsonMapObject) {
    return UpcomingGallery(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["upcoming_id"],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
    );
  }
}
