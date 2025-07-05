class Projects {
  int id;
  String title;
  String description;
  DateTime createdDate;
  int createdBy;

  Projects({
    required this.id,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.createdBy,
  });

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    createdDate: DateTime.parse(json["created_date"]),
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "created_date": createdDate.toIso8601String(),
    "created_by": createdBy,
  };
}
