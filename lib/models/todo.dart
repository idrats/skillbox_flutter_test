/// Класс реализующий модель данных Todo
class Todo {
  num id;
  num userId;
  String title;
  bool completed;
  Todo({
    this.id,
    this.userId,
    this.title,
    this.completed,
  });

  factory Todo.fromJson(Map json) {
    if (json == null) return null;

    return Todo(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> get json => {
        'id': id,
        'userId': userId,
        'title': title,
        'completed': completed,
      }..removeWhere((key, value) => value == null);

  @override
  String toString() => json.toString();
}
