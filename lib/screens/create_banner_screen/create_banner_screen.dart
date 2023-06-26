import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../constants/constants.dart';
import '../../layout/main_layout/cubit/layout_cubit.dart';
import '../../layout/new_post_layout/cubit/new_post_cubit.dart';
import '../../layout/new_post_layout/cubit/new_post_states.dart';

class CreateBannerScreen extends StatelessWidget {

  const CreateBannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController bannerUrlController = TextEditingController();
    LayoutCubit layoutCubit = LayoutCubit.get(context);
    return BlocConsumer<NewPostCubit, NewPostStates>(
        listener: (context, state) {
      if (state is NewPostCreateBannerSuccessState) {
        defToast2(context: context, msg: 'Successfully banner added' ,dialogType: DialogType.success).then((value) {
          Navigator.pop(context);
          NewPostCubit.get(context).bannerImage = null;
        });
      }
    }, builder: (context, state) {
      NewPostCubit cubit = NewPostCubit.get(context);
      return Scaffold(
        appBar: AppBar(title: const Text('Create Banner'), actions: [
          TextButton(
              onPressed: () {
                if (cubit.bannerImage != null) {
                  cubit.createNewBanner(bannerUrl: bannerUrlController.text);
                }
              },
              child: const Text('Post'))
        ]),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (state is NewPostCreateBannerLoadingState)
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
                  child: TextFormField(
                    controller: bannerUrlController,
                    decoration: const InputDecoration(
                      icon: Icon(IconlyBroken.arrow_up_square),
                      hintText: 'Redirct Url',
                    ),
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
              if (cubit.bannerImage != null)
                SizedBox(
                  height: MediaQuery.of(context).size.height * (4 / 10),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        child: Image(
                          image: FileImage(cubit.bannerImage!),
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
                                cubit.deleteBannerImage();
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
                    cubit.getBannerImage();
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
