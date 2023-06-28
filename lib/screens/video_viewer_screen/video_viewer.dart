
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:better_player/better_player.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/constants.dart';

class VideoViewerScreen extends StatefulWidget {
  const VideoViewerScreen({Key? key}) : super(key: key);

  @override
  State<VideoViewerScreen> createState() => _VideoViewerScreenState();
}

class _VideoViewerScreenState extends State<VideoViewerScreen> {

  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  bool? isLoaded ;

  String videoUrl =
      "https://streamable.com/l/wum3z1/mp4.mp4";


  // BetterPlayerController? _betterPlayerController;

  @override
  void initState() {
    super.initState();
    noScreenshot.screenshotOff();
    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((value) => setState(() {
        isLoaded = true;
      }));
    _customVideoPlayerController = CustomVideoPlayerController(
      customVideoPlayerSettings:  CustomVideoPlayerSettings(alwaysShowThumbnailOnVideoPaused: true,),
      context: context,
      videoPlayerController: videoPlayerController,
    );


   /* BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);*/

  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        noScreenshot.screenshotOn().then((value) {
          Navigator.pop(context);
        });
        return false;
      },
      child: Scaffold(

        body: OrientationBuilder(
          builder:(context,orientation)
          {
            if(orientation == Orientation.portrait){
              print('portrait');
              noScreenshot.screenshotOff();

            }else{
              print('landscape');
              noScreenshot.screenshotOff();

            }
           return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black54,
                                  offset: Offset(1, 5),
                                  blurRadius: 8)
                            ]),
                        clipBehavior: Clip.antiAlias,
                        height: MediaQuery.of(context).size.height * 0.33,
                        width: double.infinity,
                        child: FancyShimmerImage(
                          imageUrl:
                              'https://firebasestorage.googleapis.com/v0/b/emad-kattara.appspot.com/o/310723217_583915710201368_6621670359857999622_n.jpg?alt=media&token=e844667f-60a1-4eb6-9708-2f52ec454ef6',
                          boxFit: BoxFit.fill,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ConditionalBuilder(
                        condition: isLoaded ?? false,
                        fallback: (context) =>
                            const CircularProgressIndicator(),
                        builder: (context) => CustomVideoPlayer(
                            customVideoPlayerController:
                                _customVideoPlayerController),
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: Image.asset('assets/player.png')),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}