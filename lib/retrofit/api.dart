import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../model/response_data.dart';
import '../model/todo.dart';

part 'api.g.dart';

class Apis {
  static const String todos = '/';
  static const String add = '/add';
}

@RestApi(baseUrl: 'https://dummyjson.com/todos')
abstract class TodoApiClient {
  factory TodoApiClient(Dio dio, {String baseUrl}) = _TodoApiClient;

  @GET(Apis.todos)
  Future<ResponseData> getTodos();
  @POST(Apis.add)
  Future<Todo> addTodo(@Body() Todo todo);
}
