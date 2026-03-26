import 'package:flutter_application_3/blocs/auth/auth_state.dart';

import 'profile_event.dart';
import 'profile_state.dart';
import 'package:flutter_application_3/repositories/profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_3/models/user.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{

  final ProfileRepo repository;

  ProfileBloc(this.repository) : super(ProfileInitial())
  {
    on<LoadProfileEvent>(__loadProfileEvent);
  }

  Future<void> __loadProfileEvent(LoadProfileEvent event, Emitter<ProfileState> emit) async{
    emit(ProfileLoading());
    try{
      final User profile = await repository.getProfile(event.id, event.api);
      emit(ProfileSuccess(profile));
    }

    catch(e)
    {
      emit(ProfileFailure(e.toString()));
    }
  }

}