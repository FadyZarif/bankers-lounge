import 'package:dio/dio.dart';

class DioHelper{
   static Dio? dio;
   static init(){
      dio = Dio(
        BaseOptions(
          baseUrl: 'https://fcm.googleapis.com/fcm/',
          receiveDataWhenStatusError:true,
          headers: {
            'Content-Type' : 'application/json',
            'Authorization' : 'key=AAAAbGJNaso:APA91bEQDG3nhiQfelHoFkqJ07qwpKFMeEXBYmiYs1Jy-Kai6yYFhu4cvn3YVyjJwPQ21wlzhJt_KaTPJpddnRzqw4o5wYjxp_1LtNS6iv1Gdp48BLHj1HrFbBr5SOvfOozyRlvueU6V'
          }
        )
      );
   }
   static Future<Response> sendNotification({
     required String? token,
     String? title,
     String? body,
     String? image,
   })
   async{

     return await dio!.post(
       'send',
       data: {
         "to":token,
         "notification" : {
           "title" : title,
           "body" : body,
           "image": image,
           "sound" : "default"
         },
         "android":{
           "priority":"HIGH",
           "notification":{
             "notification_priority":"PRIORITY_MAX",
             "sound":"default",
             "default_sound":true,
             "default_vibrate_timings":true,
             "default_light_settings":true
           }
         },
         // "data":{
         //   "type":"order",
         //   "id":"87",
         //   "click_action":"FLUTTER_NOTIFICATION_CLICK"
         // }
       },
     );
   }
}