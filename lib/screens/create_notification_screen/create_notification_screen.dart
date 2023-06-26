import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../constants/constants.dart';
import '../../layout/main_layout/cubit/layout_cubit.dart';
import '../../layout/new_post_layout/cubit/new_post_cubit.dart';
import '../../layout/new_post_layout/cubit/new_post_states.dart';

class CreateNotificationScreen extends StatelessWidget {
  const CreateNotificationScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    TextEditingController notificationTitleController = TextEditingController();
    TextEditingController notificationBodyController = TextEditingController();
    final List<String> items = [
      'allUsers',
      'students',
      'visitors',
    ];
    LayoutCubit layoutCubit = LayoutCubit.get(context);

    return BlocConsumer<NewPostCubit, NewPostStates>(
        listener: (context, state) {
      if (state is NewPostCreateNotificationSuccessState) {
        defToast2(
                context: context,
                msg: 'Successfully Notification added',
                dialogType: DialogType.success)
            .then((value) {
          Navigator.pop(context);
          NewPostCubit.get(context).notificationImage = null;
        });
      }
    }, builder: (context, state) {
      NewPostCubit cubit = NewPostCubit.get(context);
      return Scaffold(
        appBar: AppBar(title: const Text('Create Notification'), actions: [
          TextButton(
              onPressed: () {
                if (cubit.selectedValue != null) {
                  cubit.createNewNotification(topic: cubit.selectedValue!,title: notificationTitleController.text,body: notificationBodyController.text);
                }else{
                  defToast2(context: context, msg: 'Please, Select Target', dialogType: DialogType.error);
                }
              },
              child: const Text('Post'))
        ]),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (state is NewPostCreateNotificationLoadingState)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: LinearProgressIndicator(),
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          NetworkImage(layoutCubit.adminModel!.image!),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      layoutCubit.adminModel!.name!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  child: TextFormField(
                    controller: notificationTitleController,
                    decoration: const InputDecoration(
                      icon: Icon(IconlyBroken.edit_square),
                      hintText: 'Title',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: notificationBodyController,
                    decoration: const InputDecoration(
                      icon: Icon(IconlyBroken.info_circle),
                      hintText: 'Body',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      const Icon(IconlyBroken.graph,color: Colors.grey,),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            hint: Expanded(
                              child: Text(
                                'Select Target',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ),
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: cubit.selectedValue,
                            onChanged: (value) {
                              cubit.selectTarget(value!);
                            },
                            buttonStyleData: const ButtonStyleData(
                              height: 40,
                              width: 140,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (cubit.notificationImage != null)
                SizedBox(
                  height: MediaQuery.of(context).size.height * (4 / 10),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        child: Image(
                          image: FileImage(cubit.notificationImage!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          //height: 450,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.5),
                          radius: 15,
                          child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 18,
                              onPressed: () {
                                cubit.deleteNotificationImage();
                              },
                              icon: const Icon(
                                IconlyBroken.delete,
                                color: Colors.white,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              TextButton(
                  onPressed: () {
                    cubit.getNotificationImage();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(IconlyBroken.image),
                      SizedBox(
                        width: 5,
                      ),
                      Text('add photo'),
                    ],
                  )),
            ],
          ),
        ),
      );
    });
  }
}
