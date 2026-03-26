import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_application_3/models/user.dart';

part 'rest_api.g.dart';


@RestApi(baseUrl: "https://jsonplaceholder.typicode.com/" )
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @GET('/users/{id}')
  Future<User> getProfile(@Path() String id );
}



