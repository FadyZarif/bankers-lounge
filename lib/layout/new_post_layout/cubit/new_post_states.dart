abstract class NewPostStates{}

class NewPostInitState extends NewPostStates{}
class NewPostSelectTargetState extends NewPostStates{}

class NewPostPostImgPickedSuccessState extends NewPostStates{}
class NewPostPostImgPickedErrorState extends NewPostStates{}
class NewPostPostImgDeletedSuccessState extends NewPostStates{}
class NewPostPostImgDeletedErrorState extends NewPostStates{}

class NewPostBannerImgPickedSuccessState extends NewPostStates{}
class NewPostBannerImgPickedErrorState extends NewPostStates{}
class NewPostBannerImgDeletedSuccessState extends NewPostStates{}
class NewPostBannerImgDeletedErrorState extends NewPostStates{}

class NewPostNotificationImgPickedSuccessState extends NewPostStates{}
class NewPostNotificationImgPickedErrorState extends NewPostStates{}
class NewPostNotificationImgDeletedSuccessState extends NewPostStates{}
class NewPostNotificationImgDeletedErrorState extends NewPostStates{}

class NewPostCreatePostLoadingState extends NewPostStates{}
class NewPostCreatePostSuccessState extends NewPostStates{}
class NewPostCreatePostErrorState extends NewPostStates{
  final String error ;

  NewPostCreatePostErrorState(this.error);
}

class NewPostCreateBannerLoadingState extends NewPostStates{}
class NewPostCreateBannerSuccessState extends NewPostStates{}
class NewPostCreateBannerErrorState extends NewPostStates{}

class NewPostCreateNotificationLoadingState extends NewPostStates{}
class NewPostCreateNotificationSuccessState extends NewPostStates{}
class NewPostCreateNotificationErrorState extends NewPostStates{}