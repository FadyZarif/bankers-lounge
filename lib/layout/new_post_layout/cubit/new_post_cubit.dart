import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/constants.dart';
import '../../../models/ads_banner_model.dart';
import '../../../models/post_model.dart';
import '../../../network/remote/dio_helper.dart';
import 'new_post_states.dart';

class NewPostCubit extends Cubit<NewPostStates> {
  NewPostCubit() : super(NewPostInitState());

  static NewPostCubit get(context) => BlocProvider.of(context);

  ImagePicker picker = ImagePicker();
  File? postImage;

  Future<void> getPostImage() async {
    XFile? pickedFile = await picker.pickImage(
      imageQuality: 25,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(NewPostPostImgPickedSuccessState());
    } else {
      // print('No Image Selected');
      defToast(msg: 'No Image Selected');
      emit(NewPostPostImgPickedErrorState());
    }
  }

  File? bannerImage;

  Future<void> getBannerImage() async {
    XFile? pickedFile = await picker.pickImage(
      imageQuality: 25,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      bannerImage = File(pickedFile.path);
      emit(NewPostBannerImgPickedSuccessState());
    } else {
      defToast(msg: 'No Image Selected');
      emit(NewPostBannerImgPickedErrorState());
    }
  }

  File? notificationImage;

  Future<void> getNotificationImage() async {
    XFile? pickedFile = await picker.pickImage(
      imageQuality: 25,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      notificationImage = File(pickedFile.path);
      emit(NewPostNotificationImgPickedSuccessState());
    } else {
      // print('No Image Selected');
      defToast(msg: 'No Image Selected');
      emit(NewPostNotificationImgPickedErrorState());
    }
  }

  Future<void> deletePostImage() async {
    if (postImage != null) {
      postImage = null;
      emit(NewPostPostImgDeletedSuccessState());
    } else {
      emit(NewPostPostImgDeletedErrorState());
    }
  }

  Future<void> deleteBannerImage() async {
    if (bannerImage != null) {
      bannerImage = null;
      emit(NewPostBannerImgDeletedSuccessState());
    } else {
      emit(NewPostBannerImgDeletedErrorState());
    }
  }

  Future<void> deleteNotificationImage() async {
    if (notificationImage != null) {
      notificationImage = null;
      emit(NewPostNotificationImgDeletedSuccessState());
    } else {
      emit(NewPostNotificationImgDeletedErrorState());
    }
  }

  void createNewPost({String? postText, String? postUrl}) {
    emit(NewPostCreatePostLoadingState());

    if (postImage != null) {
      FirebaseStorage.instance
          .ref()
          .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
          .putFile(postImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          PostModel postModel = PostModel(
            dateTime: DateTime.now().toString(),
            postImage: value,
            postText: postText,
            postUrl: postUrl,
          );
          FirebaseFirestore.instance
              .collection('posts')
              .add(postModel.toMap())
              .then((value) {
            DioHelper.sendNotification(
                token: '/topics/allUsers',
                title: 'Banker\'s Lounge Academy',
                body: postModel.postText,
                image: postModel.postImage);
            emit(NewPostCreatePostSuccessState());
          }).catchError((error) {
            defToast(msg: error.toString());
            emit(NewPostCreatePostErrorState(error));
          });
        });
      });
    } else {
      PostModel postModel = PostModel(
          dateTime: DateTime.now().toString(),
          postText: postText,
          postUrl: postUrl);
      FirebaseFirestore.instance
          .collection('posts')
          .add(postModel.toMap())
          .then((value) {
        DioHelper.sendNotification(
            token: '/topics/allUsers',
            title: 'Banker\'s Lounge Academy',
            body: postModel.postText);
        emit(NewPostCreatePostSuccessState());
      }).catchError((error) {
        defToast(msg: error.toString());
        emit(NewPostCreatePostErrorState(error));
      });
    }
  }

  void createNewBanner({String? bannerUrl}) {
    emit(NewPostCreateBannerLoadingState());
    if (bannerImage != null) {
      FirebaseStorage.instance
          .ref()
          .child('adsBanners/${Uri.file(bannerImage!.path).pathSegments.last}')
          .putFile(bannerImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          AdsBannerModel bannerModel = AdsBannerModel(
            bannerImgUrl: value,
            bannerWebUrl: bannerUrl,
            dateTime: DateTime.now().toString()
          );
          FirebaseFirestore.instance
              .collection('adsBanner')
              .add(bannerModel.toJson())
              .then((value) {
            emit(NewPostCreateBannerSuccessState());
          }).catchError((error) {
            defToast(msg: error.toString());
            emit(NewPostCreateBannerErrorState());
          });
        });
      });
    }
  }

  void createNewNotification({String? title,String? body,required String topic}){
    emit(NewPostCreateNotificationLoadingState());
    if(notificationImage != null){
      FirebaseStorage.instance
          .ref()
          .child('notifications/${Uri.file(notificationImage!.path).pathSegments.length}')
          .putFile(notificationImage!)
          .then((p) {
            p.ref.getDownloadURL().then((value) {
              DioHelper.sendNotification(token: '/topics/$topic', title: title, body: body,image: value).then((value){
                emit(NewPostCreateNotificationSuccessState());
              }).catchError((onError){
                defToast(msg: onError.toString());
                emit(NewPostCreateNotificationErrorState());
              });
            });
      }).catchError((onError){
        defToast(msg: onError.toString());
        emit(NewPostCreateNotificationErrorState());
      });
    }else{
      DioHelper.sendNotification(token: '/topics/$topic', title: title, body: body).then((value){
        emit(NewPostCreateNotificationSuccessState());
      }).catchError((onError){
        defToast(msg: onError.toString());
        emit(NewPostCreateNotificationErrorState());
      });
    }
  }

  String? selectedValue;

  void selectTarget(String target){
    selectedValue = target;
    emit(NewPostSelectTargetState());

  }
}
