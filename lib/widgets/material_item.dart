
import 'package:bankerslounge/screens/video_viewer_screen/video_viewer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants.dart';
import '../models/material_model.dart';
import '../screens/pdf_viewer_screen/pdf_viewer_screen.dart';

class MaterialItem extends StatelessWidget {
  final MaterialModel materialModel;

  const MaterialItem({Key? key, required this.materialModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    noScreenshot.screenshotOn();
    return InkWell(
      onTap: () {
        if (materialModel.isVideo!) {
          Navigator.push(
              context,
              CenterTransition(VideoViewerScreen(
              )));
        }
        if (materialModel.isPdf!) {
          Navigator.push(
              context,
              CenterTransition(PdfViewerScreen(
                materialModel: materialModel,
              )));
        } else {
          launchUrl(Uri.parse(materialModel.url!),
              mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsetsDirectional.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Color(0xff012623), borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              materialModel.name!,
              style: TextStyle(
                color: Color(0xfff8dca3),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
