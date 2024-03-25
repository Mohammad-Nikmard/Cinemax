class UserApp {
  String name;
  String imagePath;

  UserApp(this.name, this.imagePath);

  factory UserApp.withJson(Map<String, dynamic> jsonMapObject) {
    return UserApp(
      jsonMapObject['username'],
      jsonMapObject['profile_pic'],
    );
  }
}
