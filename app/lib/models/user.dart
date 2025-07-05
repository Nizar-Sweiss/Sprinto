class User {
  int id;
  String userName;
  String password;

  User({
    required this.id,
    required this.userName,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    userName: json["user_name"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_name": userName,
    "password": password,
  };
}