import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';
import '../../screens/sginin_screen/sginin_screen.dart';
import '../../widgets/drawer_info.dart';
import '../new_post_layout/new_post_layout.dart';
import 'cubit/layout_cubit.dart';
import 'cubit/layout_states.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // LayoutCubit cubit = LayoutCubit.get(context);
    //cubit.getUserData();
    return BlocConsumer<LayoutCubit, LayoutStates>(listener: (context, state) {
      if (state is LayoutNewPostState) {
        Navigator.push(context, BottomScaleTransition(const NewPostLayout()));
        // navigateTo(context, NewPostLayout());
      }
      if (state is LayoutSignOutSuccessState) {
        navigateToReplacement(context, SigninScreen());
      }
    }, builder: (context, state) {
      LayoutCubit cubit = LayoutCubit.get(context);
      return ConditionalBuilder(
        condition: cubit.userModel != null && cubit.adminModel != null && cubit.titlesList != null,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titlesList![cubit.currentIndex]),
              actions: [
                // IconButton(
                //     onPressed: () {
                //     }, icon: Icon(IconlyBroken.notification)),
                // IconButton(onPressed: () {
                //   // navigateTo(context, SearchScreen( cubit: cubit,));
                //   }, icon: Icon(IconlyBroken.search)),



                Builder(builder: (context) {
                  return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: const Icon(FontAwesomeIcons.bars));
                })
              ],
            ),
            endDrawer: Drawer(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.29,
                    color: Colors.lightBlueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      verticalDirection: VerticalDirection.up,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawerInfo(
                            icon: IconlyBold.location,
                            title: cubit.userModel!.city!),
                        DrawerInfo(
                            icon: IconlyBold.call,
                            title: cubit.userModel!.phone!),
                        const SizedBox(
                          height: 5,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DrawerInfo(
                              icon: IconlyBold.message,
                              title: cubit.userModel!.email!),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            cubit.userModel!.name!,
                            style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.lightBlueAccent[100],

                    onTap: () {
                      navigateToReplacement(context, const MainLayout());
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Colors.lightBlueAccent,
                      ),
                      title: Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      minLeadingWidth: 20,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.lightBlueAccent[100],

                    onTap: () {},
                    child: const ListTile(
                      leading: Icon(
                        Icons.headset_mic,
                        color: Colors.lightBlueAccent,
                      ),
                      title: Text(
                        'Help',
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      minLeadingWidth: 20,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.lightBlueAccent[100],

                    onTap: () {},
                    child: const ListTile(
                      leading: Icon(
                        Icons.group,
                        color: Colors.lightBlueAccent,
                      ),
                      title: Text(
                        'Invite Friend',
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      minLeadingWidth: 20,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.lightBlueAccent[100],

                    onTap: () {},
                    child: const ListTile(
                      leading: Icon(
                        Icons.share,
                        color: Colors.lightBlueAccent,
                      ),
                      title: Text(
                        'Rate App',
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      minLeadingWidth: 20,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.lightBlueAccent[100],

                    onTap: () {},
                    child: const ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Colors.lightBlueAccent,
                      ),
                      title: Text(
                        'About Us',
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      minLeadingWidth: 20,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.lightBlueAccent[100],
                    onTap: () {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.question,
                          title: 'Are you sure you want to log out?',
                          // autoDismiss: false,
                          btnOkText: 'Yes, log out',
                          // btnOkColor: Colors.blue,
                          btnOkOnPress: () {
                            currentUser = null;
                            cubit.signOut();
                          },
                          // btnCancelText: 'Cancel',
                          btnCancelOnPress: () {})
                          .show();
                    },
                    child: const ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.lightBlueAccent,
                      ),
                      title: Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      minLeadingWidth: 20,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.lightBlueAccent.withOpacity(0.0),
                                Colors.lightBlueAccent.withOpacity(0.5),
                                Colors.lightBlueAccent
                              ],
                            ),
                            borderRadius: BorderRadiusDirectional.circular(10),
                            // boxShadow:Responsive.isDesktop(context)?  [
                            //   BoxShadow(color: Colors.black26,offset: Offset(0, 2),blurRadius: 4)
                            // ]:null
                          ),
                          height: 1,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Contact Us',
                            style: TextStyle(color: Colors.lightBlueAccent)),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Colors.lightBlueAccent.withOpacity(0.0),
                                Colors.lightBlueAccent.withOpacity(0.5),
                                Colors.lightBlueAccent
                              ],
                            ),
                            borderRadius: BorderRadiusDirectional.circular(10),
                            // boxShadow:Responsive.isDesktop(context)?  [
                            //   BoxShadow(color: Colors.black26,offset: Offset(0, 2),blurRadius: 4)
                            // ]:null
                          ),
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            launchUrl(Uri.parse('https://facebook.com/BankersLoungeAcademy/'),mode: LaunchMode.externalApplication);
                          },
                          icon: const Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                          )),
                      ShaderMask(
                          shaderCallback: (rect) => const LinearGradient(
                                colors: [
                                  Color(0xFF405DE6),
                                  Color(0xFF5B51D8),
                                  Color(0xFF833AB4),
                                  Color(0xFFC13584),
                                  Color(0xFFFD1D1D),
                                  Color(0xFFF77737),
                                  Color(0xFFFCAF45),
                                  Color(0xFFFFDC80),
                                ],
                            begin: Alignment.topCenter,end: Alignment.bottomCenter,
                              ).createShader(rect),
                          child: IconButton(
                              onPressed: () {
                                launchUrl(
                                    Uri.parse(
                                        'https://www.instagram.com/bankers.lounge/'),
                                    mode: LaunchMode.externalApplication);
                              },
                              icon: const Icon(
                                FontAwesomeIcons.instagram,
                                color: Colors.redAccent,
                              ))),
                      IconButton(
                          onPressed: () {
                            launchUrl(
                                Uri.parse(
                                    'https://wa.me/201115778000'),
                                mode: LaunchMode.externalApplication);
                          },
                          icon: const Icon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () {
                            launchUrl(
                                Uri.parse(
                                    'https://www.youtube.com/@bankersloungechannel2002'),
                                mode: LaunchMode.externalApplication);
                          },
                          icon: const Icon(
                            FontAwesomeIcons.youtube,
                            color: Colors.red,
                          )),
                      IconButton(
                          onPressed: () {
                            launchUrl(
                                Uri.parse(
                                    'https://linkedin.com/company/bankers-lounge/'),
                                mode: LaunchMode.externalApplication);
                          },
                          icon: const Icon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () {
                            launchUrl(
                                Uri.parse(
                                    'https://goo.gl/maps/be3XXNccXhCjUSSh8'),
                                mode: LaunchMode.externalApplication);
                          },
                          icon: const Icon(
                            FontAwesomeIcons.locationDot,
                            color: Colors.red,
                          )),
                    ],
                  )
                ],
              ),
            ),
            body: cubit.screensList?[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomNavItems!,
              onTap: (i) {
                cubit.changeBottomNav(i);
              },
              currentIndex: cubit.currentIndex,
            ),
          );
        },
        fallback: (context) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    });
  }
}
