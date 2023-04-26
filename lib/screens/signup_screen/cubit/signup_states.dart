abstract class SignupState {}

class SignupInitialState extends SignupState{}

class SignupSelectCityState extends SignupState{}


class LoginChangeVisibilityState extends SignupState{}


class SignupLoadingState extends SignupState{}
class SignupSuccessState extends SignupState{

}
class SignupErrorState extends SignupState{
  final String error;

  SignupErrorState(this.error);

}

class CreateSuccessState extends SignupState{
  final String uId;

  CreateSuccessState(this.uId);
}
class CreateErrorState extends SignupState{
  final String error;

  CreateErrorState(this.error);

}