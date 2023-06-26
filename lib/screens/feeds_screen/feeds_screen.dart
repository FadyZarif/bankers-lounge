import 'package:card_swiper/card_swiper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/post_item.dart';
import 'cubit/feeds_cubit.dart';
import 'cubit/feeds_states.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<FeedsCubit,FeedsStates>(
      listener:(context,state) {},
      builder:(context,state) {
        FeedsCubit feedsCubit = FeedsCubit.get(context);
        return Scaffold(
            body: ConditionalBuilder(
              condition: feedsCubit.adsBannerList != null && feedsCubit.postsList != null,
              builder:(context)=> SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.33,
                        child:Swiper(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: ()async{
                                if(feedsCubit.adsBannerList![index].bannerWebUrl != null) {
                                  await launchUrl(
                                    Uri.parse(feedsCubit.adsBannerList![index].bannerWebUrl!),
                                    mode: LaunchMode.externalApplication
                                );
                                }
                              },
                              child: FancyShimmerImage(
                                imageUrl: feedsCubit.adsBannerList![index].bannerImgUrl!,
                                boxFit: BoxFit.fill,
                                errorWidget: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/681px-Placeholder_view_vector.svg.png'),
                              )
                              // Image.network(
                              //   feedsCubit.adsBannerList![index].bannerImgUrl!,
                              //   fit: BoxFit.fill,
                              // ),
                            );
                          },
                          indicatorLayout: PageIndicatorLayout.SCALE,
                          autoplay: true,
                          itemCount: feedsCubit.adsBannerList!.length,
                          pagination: const SwiperPagination(
                              builder: DotSwiperPaginationBuilder(
                                color: Colors.white,
                              )
                          ),
                        )
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) => PostItem(
                        postModel: feedsCubit.postsList![i], i: i,
                      ),
                      separatorBuilder: (context, i) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: feedsCubit.postsList!.length,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              fallback:(context)=> const Center(child: CircularProgressIndicator()),
            )
        );
      } ,
    );
  }
}
