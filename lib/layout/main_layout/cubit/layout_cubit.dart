

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
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
  List<BottomNavigationBarItem>? bottomNavItems;
  List<Widget>? screensList;
  List<String>? titlesList;

  void getUserData(){
    emit(LayoutGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).snapshots().listen((value) async {
      userModel = UserModel.fromJson(value.data()!);
      currentUser = userModel;
      await subscribeFirebaseMessaging();
      // getAllUsers();
      bottomNavItems = [
        const BottomNavigationBarItem(icon: Icon(IconlyBroken.home), label: 'Home'),
        const BottomNavigationBarItem(icon: Icon(IconlyBroken.video), label: 'Radio'),
        if(userModel?.role == 'admin')
        const BottomNavigationBarItem(icon: Icon(IconlyBroken.upload), label: 'Post'),
        const BottomNavigationBarItem(icon: Icon(IconlyBroken.paper), label: 'Material'),
        if(userModel?.role == 'admin')
        const BottomNavigationBarItem(icon: Icon(IconlyBroken.user_2), label: 'Users'),
      ];
      screensList = [
        const FeedsScreen(),
        RadioScreen(),
        if(userModel?.role == 'admin')
        RadioScreen(),
        const MaterialScreen(),
        if(userModel?.role == 'admin')
        const UsersLayout()
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
      // print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      // print(error.toString());
      defToast(msg: error.toString());
      emit(LayoutGetUserErrorState(error.message));
    });
  }

  Future<void> subscribeFirebaseMessaging() async {
    await FirebaseMessaging.instance.deleteToken();
    await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.instance.subscribeToTopic('allUsers');
    if(userModel?.role == 'student'){
      FirebaseMessaging.instance.subscribeToTopic('students');
      FirebaseMessaging.instance.unsubscribeFromTopic('visitors');
    }
    if(userModel?.role == 'visitor'){
      FirebaseMessaging.instance.subscribeToTopic('visitors');
      FirebaseMessaging.instance.unsubscribeFromTopic('students');
    }
    if(userModel?.city == 'القاهرة'){
      FirebaseMessaging.instance.subscribeToTopic('Cairo');
    }else if(userModel?.city == 'الجيزة'){
      FirebaseMessaging.instance.subscribeToTopic('Gizeh');
    }else if(userModel?.city == 'الشرقية'){
      FirebaseMessaging.instance.subscribeToTopic('Sharqia');
    }else if(userModel?.city == 'الدقهلية'){
      FirebaseMessaging.instance.subscribeToTopic('Dakahlia');
    }else if(userModel?.city == 'البحيرة'){
      FirebaseMessaging.instance.subscribeToTopic('Beheira');
    }else if(userModel?.city == 'القليوبية'){
      FirebaseMessaging.instance.subscribeToTopic('Qalyubia');
    }else if(userModel?.city == 'المنيا'){
      FirebaseMessaging.instance.subscribeToTopic('Minya');
    }else if(userModel?.city == 'الإسكندرية'){
      FirebaseMessaging.instance.subscribeToTopic('Alex');
    }else if(userModel?.city == 'سوهاج'){
      FirebaseMessaging.instance.subscribeToTopic('Sohag');
    }else if(userModel?.city == 'الغربية'){
      FirebaseMessaging.instance.subscribeToTopic('Gharbia');
    }else if(userModel?.city == 'أسيوط'){
      FirebaseMessaging.instance.subscribeToTopic('Asyut');
    }else if(userModel?.city == 'المنوفية'){
      FirebaseMessaging.instance.subscribeToTopic('Menofia');
    }else if(userModel?.city == 'الفيوم'){
      FirebaseMessaging.instance.subscribeToTopic('Fayyum');
    }else if(userModel?.city == 'كفر الشيخ'){
      FirebaseMessaging.instance.subscribeToTopic('Kafr');
    }else if(userModel?.city == 'قنا'){
      FirebaseMessaging.instance.subscribeToTopic('Qena');
    }else if(userModel?.city == 'بني سويف'){
      FirebaseMessaging.instance.subscribeToTopic('BeniSuef');
    }else if(userModel?.city == 'دمياط'){
      FirebaseMessaging.instance.subscribeToTopic('Damietta');
    }else if(userModel?.city == 'أسوان'){
      FirebaseMessaging.instance.subscribeToTopic('Aswan');
    }else if(userModel?.city == 'الإسماعيلية'){
      FirebaseMessaging.instance.subscribeToTopic('Ismailia');
    }else if(userModel?.city == 'الأقصر'){
      FirebaseMessaging.instance.subscribeToTopic('Luxor');
    }else if(userModel?.city == 'بورسعيد'){
      FirebaseMessaging.instance.subscribeToTopic('PortSaid');
    }else if(userModel?.city == 'السويس'){
      print('Suez');
      FirebaseMessaging.instance.subscribeToTopic('Suez');
    }else if(userModel?.city == 'سيناء'){
      FirebaseMessaging.instance.subscribeToTopic('Sinai');
    }else if(userModel?.city == 'مطروح'){
      FirebaseMessaging.instance.subscribeToTopic('Matruh');
    }else if(userModel?.city == 'البحر الأحمر'){
      FirebaseMessaging.instance.subscribeToTopic('RedSea');
    }else if(userModel?.city == 'الوادي الجديد'){
      FirebaseMessaging.instance.subscribeToTopic('NewValley');
    }else{

    }

  }

  void getAdminData() {
    emit(LayoutGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc('RLKJ6kAoWBZ2xl2RwoOFtH9smlb2').snapshots().listen((value) {
      adminModel = UserModel.fromJson(value.data()!);
      emit(LayoutGetUserSuccessState());
    }).onError((error) {
      // print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      // print(error.toString());
      defToast(msg: error.toString());
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
      // print(error.toString());
      defToast(msg: error.toString());
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
