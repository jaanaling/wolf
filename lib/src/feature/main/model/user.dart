// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wolf_survival/src/feature/main/model/notes.dart';

import 'package:wolf_survival/src/feature/main/model/resourse.dart';

class User {
  bool isTourStart;
  final List<Resourse> resourses;
  int days;
  double calories;
  double ml;
  final List<int> comlitedActions;
  final List<Notes> notes;
  User({
    required this.isTourStart,
    required this.resourses,
    required this.days,
    required this.calories,
    required this.ml,
    required this.comlitedActions,
    required this.notes,
  });

  User.init()
    : isTourStart = false,
      calories = 0,
      ml = 0,
      comlitedActions = [],
      resourses = [],
      notes = [],
      days = 0;

  User copyWith({
    bool? isTourStart,
    List<Resourse>? resourses,
    int? days,
    double? calories,
    double? ml,
    List<Notes>? notes,
    List<int>? comlitedActions,
  }) {
    return User(
      isTourStart: isTourStart ?? this.isTourStart,
      resourses: resourses ?? this.resourses,
      days: days ?? this.days,
      calories: calories ?? this.calories,
      ml: ml ?? this.ml,
      comlitedActions: comlitedActions ?? this.comlitedActions,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isTourStart': isTourStart,
      'resourses': resourses.map((x) => x.toMap()).toList(),
      'days': days,
      'calories': calories,
      'ml': ml,
      'comlitedActions': comlitedActions,
      'notes': notes.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      isTourStart: map['isTourStart'] as bool,
      resourses: List<Resourse>.from(
        (map['resourses'] as List<dynamic>).map<Resourse>(
          (x) => Resourse.fromMap(x as Map<String, dynamic>),
        ),
      ),
      days: map['days'] as int,
      calories: map['calories'] as double,
      ml: map['ml'] as double,
      notes: List<Notes>.from(
        (map['notes'] as List<dynamic>).map<Notes>(
          (x) => Notes.fromMap(x as Map<String, dynamic>),
        ),
      ),
      comlitedActions: List<int>.from(map['comlitedActions'] as List<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(isTourStart: $isTourStart, resourses: $resourses, days: $days, calories: $calories, ml: $ml, comlitedActions: $comlitedActions)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.isTourStart == isTourStart &&
        listEquals(other.resourses, resourses) &&
        other.days == days &&
        other.calories == calories &&
        other.notes == notes &&
        other.ml == ml &&
        listEquals(other.comlitedActions, comlitedActions);
  }

  @override
  int get hashCode {
    return isTourStart.hashCode ^
        resourses.hashCode ^
        days.hashCode ^
        notes.hashCode ^
        calories.hashCode ^
        ml.hashCode ^
        comlitedActions.hashCode;
  }
}
