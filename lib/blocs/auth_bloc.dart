import 'auth_event.dart';
import 'auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{

  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial())
  {
    on<RegisterEvent>(_onRegister);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit )async {
    emit(AuthLoading());
    try{
      final success = await repository.register(event.email, event.password);
      
      if(success){
        emit(AuthSuccess());
      }

      else{
        emit(AuthFailure("Registraion Failed"));
      }
    }

    catch(e){
      emit(AuthFailure(e.toString()));
    }
  }
}