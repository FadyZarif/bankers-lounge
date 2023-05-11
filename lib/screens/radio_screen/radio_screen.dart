import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class RadioScreen extends StatelessWidget {
  RadioScreen({Key? key}) : super(key: key);
  // WebViewController? controller;
  @override
  Widget build(BuildContext context) {

    /*controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            controller?.currentUrl().then((value) async {
              print('xxxxxxxxxxxxxx'+value!);
              if(
              !(value.contains('https://m.youtube.com/playlist?list=PLIYEUg1D0F4smXoJtfLWJ6IKrKPtoIGuW') ||
              value.contains('www.youtube.com/playlist?list=PLIYEUg1D0F4smXoJtfLWJ6IKrKPtoIGuW'))
              ){
               launchUrl(Uri.parse(value),mode: LaunchMode.externalApplication);
              }
            });
          },
          onPageStarted: (String url) {
            // controller?.currentUrl().then((value) {
            //   print('xxxxxxxxxxxxxx'+value!);
            //   if(!value!.contains('https://m.youtube.com/playlist?list=PLIYEUg1D0F4smXoJtfLWJ6IKrKPtoIGuW')){
            //     launchUrl(Uri.parse(value!),mode: LaunchMode.externalApplication);
            //   }
            // });
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
           await controller?.currentUrl().then((value) {
              print('oooooooooooooooooooo'+value!);
              if(
              !(value.contains('https://m.youtube.com/playlist?list=PLIYEUg1D0F4smXoJtfLWJ6IKrKPtoIGuW'))
              ){
                print('prevent');
                return NavigationDecision.prevent;
              }
            });
            // request.
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.youtube.com/playlist?list=PLIYEUg1D0F4smXoJtfLWJ6IKrKPtoIGuW'));
*/
    return Scaffold(
        body: Text('radio')
    );
  }
}
