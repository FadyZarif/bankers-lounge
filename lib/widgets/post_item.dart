import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../layout/main_layout/cubit/layout_cubit.dart';
import '../models/post_model.dart';
import '../screens/feeds_screen/cubit/feeds_cubit.dart';


class PostItem extends StatelessWidget {
  final PostModel postModel;
  final int i;
  const PostItem({Key? key, required this.postModel, required this.i}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LayoutCubit layoutCubit = LayoutCubit.get(context);
    return  InkWell(
      onTap: (){
        if(postModel.postUrl != null){
          launchUrl(Uri.parse(postModel.postUrl!),mode: LaunchMode.externalApplication);
        }
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      // cubit.getProfileData(model.uId!, context);
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(layoutCubit.adminModel!.image!),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              // cubit.getProfileData(postModel.uId!, context);
                            },
                            child: Text(
                              layoutCubit.adminModel!.name!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 15,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${DateFormat.yMMMMd().format(DateTime.parse(postModel.dateTime!))} at ${DateFormat.jm().format(DateTime.parse(postModel.dateTime!))}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (LayoutCubit.get(context).userModel!.role! == 'admin')
                    IconButton(
                      icon:  const Icon(IconlyBroken.delete,size: 22,color: Colors.red,),
                      onPressed: () {
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            title: 'Are you sure you want to delete post?',
                            btnOkText: 'Cancel',
                            btnOkOnPress: (){
                            },
                            btnCancelText: 'Yes, Delete',
                            btnCancelOnPress: (){
                              FeedsCubit.get(context).deletePost(i);
                            }
                        ).show();

                      },

                    )
                    // MoreOption()
                    // moreOption(i, cubit, context, model)
                ],
              ),
              const Divider(
                thickness: 1.0,
                height: 30,
              ),
              Text(
                postModel.postText!,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              /* MaterialButton(
                        onPressed: (){},
                        minWidth: 1,
                        height: 1,
                        padding: EdgeInsets.zero,
                        child: Text(
                          '#Software',
                          style: TextStyle(
                            color: defColor
                          ),
                        ),
                      ),*/
              if (postModel.postImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.zero,
                    elevation: 4,
                    child: FancyShimmerImage(
                      imageUrl: postModel.postImage!,
                      boxFit:BoxFit.fitWidth,
                      width: double.infinity,
                      height: 350,
                    )
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                thickness: 1.0,
                height: 30,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
