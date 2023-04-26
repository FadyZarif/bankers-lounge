abstract class SigninStates {}

class SigninInitialState extends SigninStates{}

class SigninLoadingState extends SigninStates{}

class SigninSuccessState extends SigninStates{}

class SigninErrorState extends SigninStates{
  final String error ;

  SigninErrorState(this.error);
}


class SigninChangeVisibilityState extends SigninStates {}

class SigninChangeButtonState extends SigninStates {}