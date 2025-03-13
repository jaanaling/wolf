// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Articles {
  final int id;
  final String title; // 2-4 слова
  final String description; // 20 предложений
 
  Articles({
    required this.id,
    required this.title,
    required this.description,
  });

  Articles copyWith({
    int? id,
    String? title,
    String? description,
  }) {
    return Articles(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Articles.fromMap(Map<String, dynamic> map) {
    return Articles(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Articles.fromJson(String source) =>
      Articles.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Articles(id: $id, title: $title, description: $description)';

  @override
  bool operator ==(covariant Articles other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode;
}
