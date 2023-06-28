import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../constants/constants.dart';
import '../../models/material_model.dart';

class PdfViewerScreen extends StatelessWidget {
  final MaterialModel materialModel;

  const PdfViewerScreen({Key? key, required this.materialModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _noScreenshot = NoScreenshot.instance;
    // _noScreenshot.screenshotOff();
    noScreenshot.screenshotOff();

    final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
    return WillPopScope(
      onWillPop: () async {
        noScreenshot.screenshotOn().then((value) {
          Navigator.pop(context);
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            noScreenshot.screenshotOn().then((value) {
              Navigator.pop(context);
            });
          }),
          title: Text(materialModel.name!),
        ),
       /* body:  PDF(
          enableSwipe: true,
          autoSpacing: false,
          pageFling: false,
        ).fromAsset(
          materialModel.url!,
          errorWidget: (dynamic error) => Center(child: Text(error.toString())),
        ),*/
        body: OrientationBuilder(
          builder: (context,orientation){
            if(orientation == Orientation.portrait){
              print('portrait');
              noScreenshot.screenshotOff();

            }else{
              print('landscape');
              noScreenshot.screenshotOff();

            }
         return SfPdfViewer.asset(
            materialModel.url!,
            key: pdfViewerKey,
          );
        })
      ),
    );
  }
}