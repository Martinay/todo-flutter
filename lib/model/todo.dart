import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo{
  int id;
  String todo;
  bool completed;
  int userId;

  Todo({required this.id, required this.todo, required this.completed,required this.userId});

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
