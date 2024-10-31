class Idea {
  String? id;  // O ID agora é opcional
  String title;
  String description;

  Idea({this.id, required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }

  static Idea fromMap(Map<String, dynamic> map, String id) {
    return Idea(
      id: id,
      title: map['title'],
      description: map['description'],
    );
  }
}
