import 'package:flutter_application_3/utils/rest_api.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_application_3/models/user.dart';

class ProfileRepo {
  Future<User> getProfile(String id, RestClient api) async {
    try {
      return await api.getProfile(id);
    } catch (e) {
      throw Exception('Не удалось загрузить профиль: $e');
    }
  }
}