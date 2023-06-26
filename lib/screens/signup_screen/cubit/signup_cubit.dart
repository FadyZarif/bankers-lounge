import 'package:bankerslounge/screens/signup_screen/cubit/signup_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../constants/constants.dart';
import '../../../models/user_model.dart';


class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitialState());

  static SignupCubit get(context) => BlocProvider.of(context);

  void newRegistration(
      {required String name,
        required String email,
        required String password,
        required String phone,
        required String city
      }) {
    emit(SignupLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
        city: city,
        isRequested: false,
      );
    }).catchError((error) {
      controller.error();
      emit(SignupErrorState(error.message));
      Future.delayed(const Duration(seconds: 3), () {
        controller.reset();
      });
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
    required String city,
    required bool isRequested,
  }) {
    UserModel userModel = UserModel(
        token: token,
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        role: 'visitor',
        city: city,
      isRequested: isRequested,
        image: 'https://cdn-icons-png.flaticon.com/512/274/274133.png?w=740&t=st=1664670509~exp=1664671109~hmac=daa652327bae2d17c15f4c20059f769329bfd09f38ab127909c65c7f8893005e',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toJson())
        .then((value) {
          controller.success();
      emit(CreateSuccessState(uId));
          Future.delayed(const Duration(seconds: 3), () {
            controller.reset();
          });
    }).catchError((error) {
      controller.error();
      emit(CreateErrorState(error.message));
    });
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility;

  void changePasswordVisibility() {
    emit(LoginChangeVisibilityState());
    isPassword = !isPassword;
    if (isPassword) {
      suffixIcon = Icons.visibility;
    } else {
      suffixIcon = Icons.visibility_off;
    }
  }

  String? selectedValue;

  void selectCity(String city){
    selectedValue = city;
    emit(SignupSelectCityState());

  }

  RoundedLoadingButtonController controller =  RoundedLoadingButtonController();

}
