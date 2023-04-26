import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:no_screenshot/no_screenshot.dart';

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

    final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
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
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Colors.yellow,
                semanticLabel: 'Bookmark',
              ),
              onPressed: () {
                _pdfViewerKey.currentState?.openBookmarkView();
              },
            ),
          ],
        ),
        body: SfPdfViewer.network(
          materialModel.url!,
          key: _pdfViewerKey,
        ),
      ),
    );
  }
}