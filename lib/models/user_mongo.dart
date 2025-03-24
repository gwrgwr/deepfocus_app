// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserMongo {
  String id;
  int userState;
  DateTime createdAt;
  bool firstTime;
  UserMongo({
    required this.id,
    required this.userState,
    required this.createdAt,
    required this.firstTime,
  });

  UserMongo copyWith({
    String? id,
    int? userState,
    DateTime? createdAt,
    bool? firstTime,
  }) {
    return UserMongo(
      id: id ?? this.id,
      userState: userState ?? this.userState,
      createdAt: createdAt ?? this.createdAt,
      firstTime: firstTime ?? this.firstTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userState': userState,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'firstTime': firstTime,
    };
  }

  factory UserMongo.fromMap(Map<String, dynamic> map) {
    return UserMongo(
      id: map['id'] as String,
      userState: map['userState'] as int,
      createdAt: DateTime.parse(map['createdAt'] as String),
      firstTime: map['firstTime'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserMongo.fromJson(String source) => UserMongo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserMongo(id: $id, userState: $userState, createdAt: $createdAt, firstTime: $firstTime)';
  }

  @override
  bool operator ==(covariant UserMongo other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.userState == userState &&
      other.createdAt == createdAt &&
      other.firstTime == firstTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userState.hashCode ^
      createdAt.hashCode ^
      firstTime.hashCode;
  }
}
