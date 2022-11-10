import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {

  RegisterCubit() : super(RegisterInitial());
    Future<void> createUser({required String email,required String password}) async {
      emit(RegisterLoading());
    try {
  UserCredential user = await FirebaseAuth.instance
       .createUserWithEmailAndPassword(
     email: email,
     password: password,
   );
   emit(RegisterSuccess());
} 
on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    emit(RegisterFaliure(errMessage: 'The password provided is too weak.'));
  } else if (e.code == 'email-already-in-use') {
        emit(RegisterFaliure(errMessage: 'The account already exists for that email.'));

  }
}
on Exception catch (e) {
          emit(RegisterFaliure(errMessage: 'something went wrong'));

}
  }
}
