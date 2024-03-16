class User {
  final String imagePath;
  final String name;
  final String email;
  final String password;

  const User(
    this.imagePath,
    this.name,
    this.email,
    this.password,
  );

  User copy({
    String? imagePath,
    String? name,
    String? email,
    String? password,
  }) =>
      User(
        imagePath ?? this.imagePath,
        name ?? this.name,
        email ?? this.email,
        password ?? this.password,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        json["imagePath"],
        json["name"],
        json["email"],
        json["password"],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        "name": name,
        "email": email,
        "password": password,
      };
}
