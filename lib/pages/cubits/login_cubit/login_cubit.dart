import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());



  
  Future<void> loginUser({required String email,required String password}) async {
    emit(LoginLoading());
       try {
  UserCredential user= await FirebaseAuth.instance
   .signInWithEmailAndPassword(
       email: email, password: password);
       emit(LoginSuccess());
} 
on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    emit(LoginFailure(errMessage: 'No user found for that email.'));
  } else if (e.code == 'wrong-password') {
    emit(LoginFailure(errMessage: 'Wrong password provided for that user.'));
  }}

 catch (e) {
  emit(LoginFailure(errMessage: 'something went wrong'));
}
  }
}

