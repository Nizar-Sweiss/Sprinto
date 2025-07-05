class Tasks {
  int? id;
  int? projectId;
  String? title;
  String? description;
  int? status;
  DateTime? dueDate;
  int? createdBy;
  DateTime? createdDate;

  Tasks({
    this.id,
    this.projectId,
    this.title,
    this.description,
    this.status,
    this.dueDate,
    this.createdBy,
    this.createdDate,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
      id: json['id'],
      projectId: json['project_id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      dueDate: DateTime.parse(json['due_date']),
      createdBy: json['created_by'],
      createdDate:  DateTime.parse(json['created_date']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'project_id': projectId,
    'title': title,
    'description': description,
    'status': status,
    'due_date': dueDate?.toIso8601String(),
    'created_by': createdBy,
    'created_date': createdDate,
  };
  /// ✅ This is your missing method:
  Tasks copyWith({
    int? id,
    int? projectId,
    String? title,
    String? description,
    int? status,
    DateTime? dueDate,
    int? createdBy,
    DateTime? createdDate,
  }) {
    return Tasks(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      createdBy: createdBy ?? this.createdBy,
      createdDate: createdDate ?? this.createdDate,
    );
  }

}
