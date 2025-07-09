class User {
  int id;
  String userName;
  String password;
  String token;

  User({
    required this.id,
    required this.userName,
    required this.password,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    userName: json["user_name"],
    password: json["password"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_name": userName,
    "password": password,
    "token": token,
  };
}