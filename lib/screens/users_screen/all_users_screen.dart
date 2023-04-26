
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../models/user_model.dart';
import '../../widgets/usrs_card.dart';

class AllUsersScreen extends StatelessWidget {
  AllUsersScreen({Key? key, required this.users}) : super(key: key);
  final List<UserModel> users ;

  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: users.length,
        separatorBuilder: (context,i){
          return SizedBox(height: 15,);
        },
        itemBuilder: (context,i){
          return UserCard(user: users[i]);
        },
      ),
    );
  }
}
