import 'package:bankerslounge/screens/sginin_screen/cubit/signin_states.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../constants/constants.dart';


class SigninCubit extends Cubit<SigninStates>{

  SigninCubit() : super(SigninInitialState());

  static SigninCubit get(context) => BlocProvider.of(context);

  //SigninModel? SigninModel ;


  void userSignin({required String email , required String password}){
    emit(SigninLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      uId = value.user!.uid;
      FirebaseFirestore.instance.collection('users').doc(value.user!.uid).update({"token":token}).then((value) {
        btnController.success();
        emit(SigninSuccessState());
      });

    }).catchError((error){
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      print(error.toString());
      btnController.error();
      emit(SigninErrorState(error.message));
    });
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility;

  void changePasswordVisibility(){
    emit(SigninChangeVisibilityState());
    isPassword = !isPassword;
    if(isPassword) {
      suffixIcon = Icons.visibility;
    } else {
      suffixIcon = Icons.visibility_off;
    }
  }

  final RoundedLoadingButtonController btnController =
  new RoundedLoadingButtonController();

}