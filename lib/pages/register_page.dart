import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterPage extends StatelessWidget {
  String? email;

  String? password;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
    if(state is RegisterLoading){
      EasyLoading.show();
    }
    else if (state is RegisterSuccess){
      EasyLoading.showSuccess('register successfly');
      Navigator.pushNamed(context, 'LoginPage');
      EasyLoading.dismiss(); 


    }
    else if(state is RegisterFaliure){
EasyLoading.showError(state.errMessage);
    }
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/images/scholar.png'),
                Text('Scholar Chat',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'Pacifico')),
                Row(
                  children: [
                    Text('Sign Up',
                        style: TextStyle(fontSize: 24, color: Colors.white)),
                  ],
                ),
                CustomTextField(
                  hitText: 'Email',
                  onChanged: ((data) {
                    email = data;
                  }),
                ),
                CustomTextField(
                  hitText: 'Password',
                  onChanged: ((data) {
                    password = data;
                  }),
                ),
                CustomButton(
                  onTap: (() async {
                    if (formkey.currentState!.validate()) {
                      BlocProvider.of<RegisterCubit>(context)
                          .createUser(email: email!, password: password!);
                    }
                  }),
                  title: 'Sign Up',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account ?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      child: Text(
                        '  Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        // Navigator.pushReplacementNamed(context, LoginPage.id);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
