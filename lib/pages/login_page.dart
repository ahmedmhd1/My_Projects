import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/cubits/cubit/chat_cubit.dart';
import 'package:chat_app/pages/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatelessWidget {
  String? email;

  String? password;
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state is LoginLoading){
          EasyLoading.show();
        }
        else if(state is LoginSuccess){
          EasyLoading.showSuccess('Login Scuccess');
BlocProvider.of<ChatCubit>(context).getMessages();
Navigator.pushReplacementNamed(context, 'ChatPage',arguments: email);
EasyLoading.dismiss(); 
        }
        else if(state is LoginFailure){
          EasyLoading.showError(state.errMessage);
        }
          
       
      },
      builder:(context,state)=> Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formkey,
            child: ListView(children: [
              Image.asset(
                'assets/images/scholar.png',
                height: 100,
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Scholar Chat',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'Pacifico')),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Text('LOGIN',
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              CustomTextField(
                onChanged: ((data) {
                  email = data;
                }),
                hitText: 'Email',
              ),
              SizedBox(
                height: 35,
              ),
              CustomTextField(
                onChanged: ((data) {
                  password = data;
                }),
                hitText: 'Password',
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  onTap: (() async {
                    if (formkey.currentState!.validate()) {
                      BlocProvider.of<LoginCubit>(context).loginUser(email: email!, password: password!);

                    }else{}
                  }),
                  title: 'Login',
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'don\'t have an account ?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    child: Text(
                      '  Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, 'RegistrtPage');
                      // Navigator.pushReplacementNamed(context, 'RegistrtPage');
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
