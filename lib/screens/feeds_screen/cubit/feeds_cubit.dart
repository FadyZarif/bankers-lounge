import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ads_banner_model.dart';
import '../../../models/post_model.dart';
import 'feeds_states.dart';

class FeedsCubit extends Cubit<FeedsStates> {
  FeedsCubit() : super(FeedsInitialStates());

  static FeedsCubit get(context) => BlocProvider.of(context);

  List<AdsBannerModel>? adsBannerList;

  void getAdsBanner() {
    emit(FeedsGetAdsBannerLoadingStates());
    FirebaseFirestore.instance.collection('adsBanner').orderBy('dateTime',descending: true).snapshots().listen((
        event) {
      adsBannerList = [];
      event.docs.forEach((element) {
        adsBannerList?.add(AdsBannerModel.fromJson(element.data()));
      });
      emit(FeedsGetAdsBannerSuccessStates());
    });
  }

  List<PostModel>? postsList;
  List<String>? postsId;
  void getPosts() {
    emit(FeedsGetAdsBannerLoadingStates());
    FirebaseFirestore.instance.collection('posts').orderBy('dateTime',descending: true).snapshots().listen((
        event) {
      postsList = [];
      postsId = [];
      event.docs.forEach((element) {
        postsList?.add(PostModel.fromJson(element.data()));
        postsId?.add(element.id);
      });
      emit(FeedsGetAdsBannerSuccessStates());
    });
  }

  void deletePost(int i) {
    FirebaseFirestore.instance.collection('posts').doc(postsId![i]).delete();
  }
}