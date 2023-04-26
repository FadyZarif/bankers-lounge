import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../screens/users_screen/all_users_screen.dart';
import '../../widgets/tapbar_users.dart';
import 'cubit/users_cubit.dart';
import 'cubit/users_states.dart';

class UsersLayout extends StatelessWidget {
  const UsersLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UsersCubit cubit = UsersCubit.get(context);
    if (cubit.allUsers == null) {
      print('xxxxxxxxxxxxxx');
      cubit.getAllUsers();
    }
    TextEditingController searchEditingController = cubit.searchEditingController;
    return BlocConsumer<UsersCubit, UsersStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.allUsers != null,
          builder: (context) {
            return DefaultTabController(
              length: 3,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 100,
                    bottom: TabBar(

                        isScrollable: true, tabs: [
                      Tab(
                          child: TabBarUsers(text: 'All', number: searchEditingController.text.isEmpty? cubit.allUsers!.length:cubit.allUsersFiltered!.length)
                      ),
                      Tab(
                        child: TabBarUsers(text: 'Students', number: searchEditingController.text.isEmpty? cubit.students!.length: cubit.studentsFiltered!.length),
                      ),
                      Tab(
                        child: TabBarUsers(text: 'Visitors', number: searchEditingController.text.isEmpty? cubit.visitors!.length:cubit.visitorsFiltered!.length),
                      ),
                    ]),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          IconlyBroken.search,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: searchEditingController,
                            onChanged: (q){
                              cubit.search(q);
                              },
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      AllUsersScreen(
                        users: searchEditingController.text.isEmpty ? cubit.allUsers! : cubit.allUsersFiltered!,
                      ),
                      AllUsersScreen(
                        users: searchEditingController.text.isEmpty ? cubit.students! : cubit.studentsFiltered!,
                      ),
                      AllUsersScreen(
                        users: searchEditingController.text.isEmpty ? cubit.visitors! : cubit.visitorsFiltered!,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
