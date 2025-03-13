// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Notes {
  String id;
  String text;
  Notes({required this.id, required this.text});

  Notes copyWith({String? id, String? text}) {
    return Notes(id: id ?? this.id, text: text ?? this.text);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'text': text};
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(id: map['id'] as String, text: map['text'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Notes.fromJson(String source) =>
      Notes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Notes(id: $id, text: $text)';

  @override
  bool operator ==(covariant Notes other) {
    if (identical(this, other)) return true;

    return other.id == id && other.text == text;
  }

  @override
  int get hashCode => id.hashCode ^ text.hashCode;
}
