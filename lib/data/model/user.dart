import 'package:cinemax/constants/string_constants.dart';

class UserApp {
  String id;
  String collectionId;
  String name;
  String imagePath;
  String profile;

  UserApp(this.id, this.collectionId, this.name, this.imagePath, this.profile);

  factory UserApp.withJson(Map<String, dynamic> jsonMapObject) {
    return UserApp(
      jsonMapObject['id'],
      jsonMapObject['collectionId'],
      jsonMapObject['username'],
      "${StringConstants.baseImage}/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["profile_pic"]}",
      jsonMapObject['profile_pic'],
    );
  }
}
