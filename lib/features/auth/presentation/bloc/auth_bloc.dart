import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthtrack/features/auth/data/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    
    AuthRepository authRepository = AuthRepository();

    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try{
        await authRepository.login(email: event.email, password: event.password);
        emit(AuthSuccessState());
      }
      on FirebaseAuthException catch (error){
        emit(AuthFailureState(failuremessage: error.message ?? "Authentication failed"));
      }
      catch(error){
        emit(AuthFailureState(
          failuremessage: "Unexpected error occurred",
        ));
      }
    });

    on<AuthSignupEvent>((event, emit) async {
      emit(AuthLoadingState());
      try{
        await authRepository.signUp(email: event.email, password: event.password);
      }
      on FirebaseAuthException catch (error){
        emit(AuthFailureState(failuremessage: error.message ?? "Authentication failed"));
      }
    });

    on<AuthLogoutEvent>((event, emit) async {
      emit(AuthLoadingState());
      try{
        await authRepository.Logout();
      }
      on FirebaseAuthException catch (error){
        emit(AuthFailureState(failuremessage: error.message ?? "Authentication failed"));
      }
    });
  }
}
