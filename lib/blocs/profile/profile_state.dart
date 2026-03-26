import 'package:flutter_application_3/models/user.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState{}

class ProfileLoading extends ProfileState{}

class ProfileSuccess extends ProfileState{
 final User profile;
  ProfileSuccess(this.profile);
}

class ProfileFailure extends ProfileState{
  final String error;

  ProfileFailure(this.error);

}