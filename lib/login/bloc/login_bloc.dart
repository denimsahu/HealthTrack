import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
