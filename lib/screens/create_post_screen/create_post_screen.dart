import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../constants/constants.dart';
import '../../layout/main_layout/cubit/layout_cubit.dart';
import '../../layout/new_post_layout/cubit/new_post_cubit.dart';
import '../../layout/new_post_layout/cubit/new_post_states.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({Key? key}) : super(key: key);

  TextEditingController postTextController = TextEditingController();
  TextEditingController postUrlController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    LayoutCubit layoutCubit = LayoutCubit.get(context);
    return BlocConsumer<NewPostCubit, NewPostStates>(
        listener: (context, state) {
      if (state is NewPostCreatePostSuccessState) {
        defToast2(context: context, msg: 'Successfully post added', dialogType: DialogType.success).then((value){
          Navigator.pop(context);
          NewPostCubit.get(context).postImage = null;
        });

      }
      if (state is NewPostCreatePostErrorState) {

        defToast2(context: context, msg: 'Failed, ${state.error.toString()} ', dialogType: DialogType.error);
      }
    }, builder: (context, state) {
      NewPostCubit cubit = NewPostCubit.get(context);
      return Scaffold(
        appBar: AppBar(title: Text('Create Post'), actions: [
          TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  cubit.createNewPost(postText: postTextController.text);
                }
              },
              child: const Text('Post'))
        ]),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (state is NewPostCreatePostLoadingState)
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
                  height: MediaQuery.of(context).size.height / 5,
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                        controller: postTextController,
                        maxLines: 7,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              'what is on your mind, Emad Kattara - عماد قطارة ?',
                        ),
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'write post';
                          } else {
                            return null;
                          }
                        }),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                    child: TextFormField(
                      controller: postUrlController,
                      decoration: InputDecoration(
                        icon: Icon(IconlyBroken.arrow_up_square),
                        hintText: 'Redirct Url',
                      ),
                    ))
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (cubit.postImage != null)
                SizedBox(
                  height: MediaQuery.of(context).size.height * (4 / 10),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        child: Image(
                          image: FileImage(cubit.postImage!),
                          fit: BoxFit.fitHeight,
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
                                cubit.deletePostImage();
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
                    cubit.getPostImage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(IconlyBroken.image),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('add photo'),
                    ],
                  )),
            ],
          ),
        ),
      );
    });
  }
}
