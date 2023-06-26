import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/create_banner_screen/create_banner_screen.dart';
import '../../screens/create_notification_screen/create_notification_screen.dart';
import '../../screens/create_post_screen/create_post_screen.dart';
import 'cubit/new_post_cubit.dart';

class NewPostLayout extends StatelessWidget {
  const NewPostLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>NewPostCubit(),
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 10,
              leading: const Icon(Icons.add,color: Colors.transparent,),
              bottom: const TabBar(
                isScrollable: true,
                  tabs: [
                    Tab(text: 'create post',),
                    Tab(text: 'create banner',),
                    Tab(text: 'create notification',),
                  ]
              ),
            ),
            body: TabBarView(
                children: [
                  CreatePostScreen(),
                  CreateBannerScreen(),
                  CreateNotificationScreen()
                ]
            ),
          )
      ),
    );
  }
}
