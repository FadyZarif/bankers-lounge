
import 'package:bankerslounge/screens/feeds_screen/cubit/feeds_cubit.dart';
import 'package:bankerslounge/screens/material_screen/cubit/material_cubit.dart';
import 'package:bankerslounge/screens/sginin_screen/sginin_screen.dart';
import 'package:bankerslounge/style/themes.dart';
import 'package:bankerslounge/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observer.dart';
import 'constants/constants.dart';
import 'firebase_options.dart';
import 'layout/main_layout/cubit/layout_cubit.dart';
import 'layout/main_layout/layout.dart';
import 'layout/users_layout/cubit/users_cubit.dart';
import 'network/remote/dio_helper.dart';

bool? isLogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  token = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    // defToast(msg: event.data.toString());

  });

  await FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    // defToast(msg: event.data.toString());
  });


  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    isLogin = false;
  } else {
    uId = user.uid;
    isLogin = true;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    noScreenshot.screenshotOn();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>LayoutCubit()..getUserData()..getAdminData()),
        BlocProvider(create: (context)=>FeedsCubit()..getAdsBanner()..getPosts()),
        BlocProvider(create: (context)=>MaterialCubit()..getMaterial()),
        BlocProvider(create: (context)=>UsersCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Emad Kattara',
        theme: lightTheme,
        home: MyCustomSplashScreen(screen:isLogin!? MainLayout() : SigninScreen())
      ),
    );
  }
}

