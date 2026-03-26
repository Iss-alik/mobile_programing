import 'package:flutter_application_3/utils/rest_api.dart';
abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent{
  final String id;
  final RestClient api;

  LoadProfileEvent(this.id, this.api);
}