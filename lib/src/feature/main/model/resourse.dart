// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Resourse {
  final int id;
  final String name;
  Resourse({
    required this.id,
    required this.name,
  });


  Resourse copyWith({
    int? id,
    String? name,
  }) {
    return Resourse(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Resourse.fromMap(Map<String, dynamic> map) {
    return Resourse(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Resourse.fromJson(String source) => Resourse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Resourse(id: $id, name: $name)';

  @override
  bool operator ==(covariant Resourse other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
