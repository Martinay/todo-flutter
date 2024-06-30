import 'package:flutter_application_1/model/todo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_data.g.dart';

@JsonSerializable()
class ResponseData{
  int total;
  int skip;
  int limit;
  List<Todo>todos = [];
  ResponseData({required this.total, required this.skip, required this.limit});
  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}