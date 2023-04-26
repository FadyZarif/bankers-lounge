import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:url_launcher/url_launcher.dart';

import '../layout/users_layout/cubit/users_cubit.dart';
import '../models/user_model.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.user}) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(

        customButton: Card(
          shadowColor: Colors.grey,
          elevation: 6,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(user.name!,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),softWrap: false,)),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(user.email!,softWrap: false)
                  ),
                  const SizedBox(height: 1,),
                  Row(
                    children: [
                      Text(user.phone!),
                      const Spacer(),
                      Text(user.city!)
                    ],
                  ),
                  const SizedBox(height: 1,),
                ],
              ),
            ),
            hoverColor: Colors.black,
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(user.role! == 'student'? IconlyBroken.add_user:IconlyBroken.user_3,color: Colors.blue,size: 26),
                Text(user.role!,style: const TextStyle(color: Colors.blue),)
              ],
            ),
            horizontalTitleGap: 10,
            trailing:  PopupMenuButton(
              initialValue: user.role!,
              onSelected: (value){
                if(value == 'student'){
                  UsersCubit.get(context).changeRole('student', user);
                }
                if(value == 'visitor'){
                  UsersCubit.get(context).changeRole('visitor', user);
                }
              },
              itemBuilder: (ctx){
                return [
                  const PopupMenuItem(
                      value: 'student',
                      child: Text('student')
                  ),
                  const PopupMenuItem(
                      value: 'visitor',
                      child: Text('visitor')
                  ),
                ];
              },
            ),
            splashColor: Colors.cyan,
          ),
        ),
        openWithLongPress: true,
        items: [
          ...MenuItems.firstItems.map(
                (item) =>
                DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
          ),
          const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
          ...MenuItems.secondItems.map(
                (item) =>
                DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value as MenuItem,user);
        },
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.blue,
          ),
          elevation: 8,
          offset: const Offset(40, -4),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: [
            ...List<double>.filled(MenuItems.firstItems.length, 48),
            8,
            ...List<double>.filled(MenuItems.secondItems.length, 48),
          ],
          padding: const EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [whatts, call, mail];
  static const List<MenuItem> secondItems = [cancel];

  static const whatts = MenuItem(text: 'WhatsApp', icon: FontAwesomeIcons.whatsapp);
  static const call = MenuItem(text: 'Call', icon: FontAwesomeIcons.phone);
  static const mail = MenuItem(text: 'Send Mail', icon: FontAwesomeIcons.paperPlane);
  static const cancel = MenuItem(text: 'Cancel', icon: Icons.cancel);


  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(
          item.icon,
          color: Colors.white,
          size: 22,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item,UserModel user) {
    switch (item) {
      case MenuItems.whatts:
      launchUrl(Uri.parse('https://api.whatsapp.com/send/?phone=+2${user.phone}&type=phone_number&app_absent=00'),mode: LaunchMode.externalApplication);
        break;
      case MenuItems.call:
        launchUrl(Uri.parse('tel:${user.phone}'),mode: LaunchMode.externalApplication);
        break;
      case MenuItems.mail:
        launchUrl(Uri.parse('mailto:${user.email}'),mode: LaunchMode.externalApplication);
        break;
      case MenuItems.cancel:
      //Do something
        break;
    }
  }
}
