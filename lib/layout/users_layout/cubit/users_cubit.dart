import 'package:bankerslounge/layout/users_layout/cubit/users_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../../../models/user_model.dart';

class UsersCubit extends Cubit<UsersStates> {
  UsersCubit() : super(UsersInitState());
  static UsersCubit get(context) => BlocProvider.of(context);


  List<UserModel>? allUsers;
  List<UserModel>? students;
  List<UserModel>? visitors;
  TextEditingController searchEditingController = TextEditingController();

  void getAllUsers(){
    FirebaseFirestore.instance.collection('users').where('role',isNotEqualTo: 'admin').snapshots().listen((usersDocs){
      allUsers = [];
      students = [];
      visitors = [];
      usersDocs.docs.forEach((user) {
        allUsers?.add(UserModel.fromJson(user.data()));
      });
      students?.addAll((allUsers?.where((element) => element.role == 'student'))!);
      visitors?.addAll((allUsers?.where((element) => element.role == 'visitor'))!);
      search(searchEditingController.text);
      emit(UsersGetAllUsersSuccessfulState());
    }).onError((error){
      emit(UsersGetAllUsersErrorState());
      defToast(msg: error.toString());
    });
  }

  List<UserModel>? allUsersFiltered;
  List<UserModel>? studentsFiltered;
  List<UserModel>? visitorsFiltered;
  void search(String q){
    allUsersFiltered =  allUsers?.where((element) {return (element.name!.contains(q) || element.email!.contains(q) || element.phone!.contains(q)); }).toList();
    studentsFiltered =  students?.where((element) {return (element.name!.contains(q) || element.email!.contains(q) || element.phone!.contains(q)); }).toList();
    visitorsFiltered =  visitors?.where((element) {return (element.name!.contains(q) || element.email!.contains(q) || element.phone!.contains(q)); }).toList();
    emit(UsersSearchState());
  }

  void changeRole(String role,UserModel user){
    emit(UsersChangeRoleLoadingState());
    FirebaseFirestore.instance.collection('users').doc(user.uId).update({'role':role}).then((value) {
      emit(UsersChangeRoleSuccessfulState());
    }).catchError((onError){
      emit(UsersChangeRoleErrorState());
      defToast(msg: onError.toString());
    });
  }
}