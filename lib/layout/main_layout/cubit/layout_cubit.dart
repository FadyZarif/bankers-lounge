
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../constants/constants.dart';
import '../../../models/user_model.dart';
import '../../../screens/feeds_screen/feeds_screen.dart';
import '../../../screens/material_screen/material_screen.dart';
import '../../../screens/radio_screen/radio_screen.dart';
import '../../users_layout/user_layout.dart';
import 'layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  UserModel? adminModel;
  List<BottomNavigationBarItem>? BottomNavItems;
  List<Widget>? screensList;
  List<String>? titlesList;

  void getUserData(){
    emit(LayoutGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).snapshots().listen((value) async {
      userModel = UserModel.fromJson(value.data()!);
      currentUser = userModel;
      await subscribeFirebaseMessaging();
      // getAllUsers();
      BottomNavItems = [
        BottomNavigationBarItem(icon: Icon(IconlyBroken.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(IconlyBroken.video), label: 'Radio'),
        if(userModel?.role == 'admin')
        BottomNavigationBarItem(icon: Icon(IconlyBroken.upload), label: 'Post'),
        BottomNavigationBarItem(icon: Icon(IconlyBroken.paper), label: 'Material'),
        if(userModel?.role == 'admin')
        BottomNavigationBarItem(icon: Icon(IconlyBroken.user_2), label: 'Users'),
      ];
      screensList = [
        FeedsScreen(),
        RadioScreen(),
        if(userModel?.role == 'admin')
        RadioScreen(),
        MaterialScreen(),
        if(userModel?.role == 'admin')
        UsersLayout()
        // NewPostScreen(),
        // UsersScreen(),
        // SettingsScreen(),
      ];
      titlesList = [
        'Home',
        'Radio',
        if(userModel?.role == 'admin')
        'Post',
        'Material',
        if(userModel?.role == 'admin')
        'Users',
      ];
      emit(LayoutGetUserSuccessState());
    }).onError((error) {
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      print(error.toString());
      emit(LayoutGetUserErrorState(error.message));
    });
  }

  Future<void> subscribeFirebaseMessaging() async {
    FirebaseMessaging.instance.subscribeToTopic('allUsers');
    if(userModel?.role == 'student'){
      FirebaseMessaging.instance.subscribeToTopic('students');
      FirebaseMessaging.instance.unsubscribeFromTopic('visitors');
    }
    if(userModel?.role == 'user'){
      FirebaseMessaging.instance.subscribeToTopic('visitors');
      FirebaseMessaging.instance.unsubscribeFromTopic('students');
    }
  }

  void getAdminData() {
    emit(LayoutGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc('RLKJ6kAoWBZ2xl2RwoOFtH9smlb2').snapshots().listen((value) {
      adminModel = UserModel.fromJson(value.data()!);
      emit(LayoutGetUserSuccessState());
    }).onError((error) {
      print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      print(error.toString());
      emit(LayoutGetUserErrorState(error.message));
    });
  }

  Future<void> setUserStatus({required bool isOnline}) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update({'isOnline': isOnline}).then((value) {
      emit(LayoutSetUserStatusSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LayoutSetUserStatusErrorState());
    });
  }

  int currentIndex = 0;



  void changeBottomNav(int i) {
    if (i == 2 && userModel!.role == 'admin') {
      emit(LayoutNewPostState());
    } else if(i==1){
      launchUrl(Uri.parse('https://www.youtube.com/playlist?list=PLIYEUg1D0F4smXoJtfLWJ6IKrKPtoIGuW'),mode: LaunchMode.externalApplication);
    }
    else {
      currentIndex = i;
      emit(LayoutChangeBottomNavState());
    }
  }

  void signOut(){
    FirebaseFirestore.instance.collection('users').doc(uId).update({"token":null}).then((value) {
      FirebaseAuth.instance.signOut().then((value) {
        uId = null;
        userModel = null;
        emit(LayoutSignOutSuccessState());
      });
    }).catchError((error){
      emit(LayoutSignOutErrorState());
      defToast(msg: error.toString());
    });
  }

  void openDrawer(BuildContext context){
    emit(LayoutCoverImgUploadSuccessState());
    Scaffold.of(context).openDrawer();
  }
}
