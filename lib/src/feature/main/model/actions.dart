// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UActions {
  int id;
  String title; // 2 слова
  String description; // 3 предложений
  int daytime; // от 1 до 3 (утро, день, вечер)

  List<ActionStage> stages;
  UActions({
    required this.id,
    required this.title,
    required this.description,
    required this.daytime,
    required this.stages,
  });

  UActions copyWith({
    int? id,
    String? title,
    String? description,
    int? daytime,
    List<ActionStage>? stages,
  }) {
    return UActions(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      daytime: daytime ?? this.daytime,
      stages: stages ?? this.stages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'daytime': daytime,
      'stages': stages.map((x) => x.toMap()).toList(),
    };
  }

  factory UActions.fromMap(Map<String, dynamic> map) {
    return UActions(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      daytime: map['daytime'] as int,
      stages: List<ActionStage>.from(
        (map['stages'] as List<dynamic>).map<ActionStage>(
          (x) => ActionStage.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UActions.fromJson(String source) =>
      UActions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Actions(id: $id, title: $title, description: $description, daytime: $daytime, stages: $stages)';
  }

  @override
  bool operator ==(covariant UActions other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.daytime == daytime &&
        listEquals(other.stages, stages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        daytime.hashCode ^
        stages.hashCode;
  }
}

class ActionStage {
  int number;
  String title; // 2 слова
  String description; // 10 предложений

  ActionStage({
    required this.number,
    required this.title,
    required this.description,
  });

  ActionStage copyWith({int? number, String? title, String? description}) {
    return ActionStage(
      number: number ?? this.number,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'title': title,
      'description': description,
    };
  }

  factory ActionStage.fromMap(Map<String, dynamic> map) {
    return ActionStage(
      number: map['number'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActionStage.fromJson(String source) =>
      ActionStage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ActionStage(number: $number, title: $title, description: $description)';

  @override
  bool operator ==(covariant ActionStage other) {
    if (identical(this, other)) return true;

    return other.number == number &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode => number.hashCode ^ title.hashCode ^ description.hashCode;
}
