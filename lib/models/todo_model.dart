class Todo {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.createdAt,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    final createdAtValue = json['createdAt'];
    final parsedTimestamp = createdAtValue is int
        ? createdAtValue
        : int.tryParse(createdAtValue?.toString() ?? '') ?? 0;

    return Todo(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      isDone: json['isDone'] is bool
          ? json['isDone']
          : json['isDone']?.toString().toLowerCase() == 'true',
      createdAt: DateTime.fromMillisecondsSinceEpoch(parsedTimestamp * 1000),
    );
  }
}