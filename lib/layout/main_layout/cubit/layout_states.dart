abstract class LayoutStates{}

class LayoutInitState extends LayoutStates{}

class LayoutGetUserLoadingState extends LayoutStates{}
class LayoutGetUserSuccessState extends LayoutStates{}
class LayoutGetUserErrorState extends LayoutStates{
  final String error;

  LayoutGetUserErrorState(this.error);
}

class LayoutGetAdminLoadingState extends LayoutStates{}
class LayoutGetAdminSuccessState extends LayoutStates{}
class LayoutGetAdminErrorState extends LayoutStates{
  final String error;

  LayoutGetAdminErrorState(this.error);
}

class LayoutSetUserStatusSuccessState extends LayoutStates{}
class LayoutSetUserStatusErrorState extends LayoutStates{}

class LayoutGetAllUserLoadingState extends LayoutStates{}
class LayoutGetAllUserSuccessState extends LayoutStates{}
class LayoutGetAllUserErrorState extends LayoutStates{}

class LayoutGetStoriesLoadingState extends LayoutStates{}
class LayoutGetStoriesSuccessState extends LayoutStates{}
class LayoutGetStoriesErrorState extends LayoutStates{}

class LayoutGetAllChatsLoadingState extends LayoutStates{}
class LayoutGetAllChatsSuccessState extends LayoutStates{}
class LayoutGetAllChatsErrorState extends LayoutStates{}

class LayoutGetAllMessagesSuccessState extends LayoutStates{}
class LayoutIsSeenSuccessState extends LayoutStates{}


class LayoutGetPostLoadingState extends LayoutStates{}
class LayoutGetPostSuccessState extends LayoutStates{}
class LayoutGetPostErrorState extends LayoutStates{}

class LayoutGetPostLikersLoadingState extends LayoutStates{}
class LayoutGetPostLikersSuccessState extends LayoutStates{}
class LayoutGetPostLikersErrirState extends LayoutStates{}

class LayoutGetPostCommentersLoadingState extends LayoutStates{}
class LayoutGetPostCommentersSuccessState extends LayoutStates{}
class LayoutGetPostCommentersErrirState extends LayoutStates{}



class LayoutLikePostSuccessState extends LayoutStates{}
class LayoutLikePostErrorState extends LayoutStates{}

class LayoutGetLikePostSuccessState extends LayoutStates{}
class LayoutGetLikePostLoadingState extends LayoutStates{}

class LayoutChangeBottomNavState extends LayoutStates{}

class LayoutNewPostState extends LayoutStates{}


class LayoutProfileImgPickedSuccessState extends LayoutStates{}
class LayoutProfileImgPickedErrorState extends LayoutStates{}

class LayoutCoverImgPickedSuccessState extends LayoutStates{}
class LayoutCoverImgPickedErrorState extends LayoutStates{}

class LayoutPostImgPickedSuccessState extends LayoutStates{}
class LayoutPostImgPickedErrorState extends LayoutStates{}
class LayoutPostImgDeletedSuccessState extends LayoutStates{}
class LayoutPostImgDeletedErrorState extends LayoutStates{}

class LayoutPostImgRemoveSuccessState extends LayoutStates{}


class LayoutProfileImgUploadLoadingState extends LayoutStates{}
class LayoutProfileImgUploadSuccessState extends LayoutStates{}
class LayoutProfileImgUploadErrorState extends LayoutStates{}


class LayoutCoverImgUploadLoadingState extends LayoutStates{}
class LayoutCoverImgUploadSuccessState extends LayoutStates{}
class LayoutCoverImgUploadErrorState extends LayoutStates{}


class LayoutUserUpdateLoadingState extends LayoutStates{}
class LayoutUserUpdateErrorState extends LayoutStates{}

class LayoutCreatePostLoadingState extends LayoutStates{}
class LayoutCreatePostSuccessState extends LayoutStates{}
class LayoutCreatePostErrorState extends LayoutStates{}

class LayoutEditPostLoadingState extends LayoutStates{}
class LayoutEditPostSuccessState extends LayoutStates{}
class LayoutEditPostErrorState extends LayoutStates{}


class LayoutWriteCommentSuccessState extends LayoutStates{}
class LayoutWriteCommentLoadingState extends LayoutStates{}
class LayoutWriteCommentErrorState extends LayoutStates{}

class LayoutSendMessageSuccessState extends LayoutStates{}
class LayoutSendMessageErrorState extends LayoutStates{}

class LayoutGetMessagesSuccessState extends LayoutStates{}
class LayoutGetMessageErrorState extends LayoutStates{}

class LayoutAddPhotosLoadingState extends LayoutStates{}
class LayoutAddPhotosSuccessState extends LayoutStates{}
class LayoutAddPhotosErrorState extends LayoutStates{}

class LayoutGetPublisherLoadingState extends LayoutStates{}
class LayoutGetPublisherSuccessState extends LayoutStates{}
class LayoutGetPublisherErrorState extends LayoutStates{}

class LayoutSignOutSuccessState extends LayoutStates{}
class LayoutSignOutErrorState extends LayoutStates{}








