import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/response_data.dart';

part 'api.g.dart';

class Apis {
  static const String todos = '/';
}

@RestApi(baseUrl: 'https://dummyjson.com/todos')
abstract class TodoApiClient {
  factory TodoApiClient(Dio dio, {String baseUrl}) = _TodoApiClient;

  @GET(Apis.todos)
  Future<ResponseData> getTodos();
}
