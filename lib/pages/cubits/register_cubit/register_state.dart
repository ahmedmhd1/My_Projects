part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {}
class RegisterFaliure extends RegisterState {
  String errMessage;
  RegisterFaliure({required this.errMessage});
}
