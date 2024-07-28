class Task {
  final String id;
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String status;
  final String user;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;


  Task({
    required this.id,
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,

  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'],
      image: json['image'],
      title: json['title'],
      desc: json['desc'],
      priority: json['priority'],
      status: json['status'],
      user: json['user'],
      v: json['__v']??0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
