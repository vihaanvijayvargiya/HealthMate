import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:health_mate/globle.dart';
import 'package:url_launcher/url_launcher.dart';




class MeetWeb extends StatefulWidget {
  final String url;

  const MeetWeb({super.key, required this.url,});

  @override
  State<MeetWeb> createState() => _MeetWebState();
}

class _MeetWebState extends State<MeetWeb> {
  double _progress = 0;
  late InAppWebViewController  inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{

        var isLastPage = await inAppWebViewController.canGoBack();

        if(isLastPage){
          inAppWebViewController.goBack();
          return false;
        }

        return true;
      },
      child: Scaffold(

        appBar: AppBar(
          title: Text("Live consultant",style: TextStyle(color: Colors.white,fontSize: 20),),
          backgroundColor: deepColor,
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse('https://meet.google.com/gun-vith-kdk?authuser=0')
                  // url: Uri.parse(widget.url)
              ),
              onWebViewCreated: (InAppWebViewController controller){
                inAppWebViewController = controller;
              },
              onProgressChanged: (InAppWebViewController controller , int progress){
                setState(() {
                  _progress = progress / 100;
                });
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url;

                if (kIsWeb) {
                  // On web platform, stay in the WebView
                  return NavigationActionPolicy.ALLOW;
                }

                if (uri != null && uri.host == "maps.google.com") {
                  // Open Google Maps URL in external browser
                  await launch(uri.toString(), forceWebView: false);
                  return NavigationActionPolicy.CANCEL;
                }

                // Continue loading the URL in the WebView
                return NavigationActionPolicy.ALLOW;
              },
            ),

            _progress < 1 ? Container(
              child: LinearProgressIndicator(
                value: _progress,
              ),
            ):SizedBox()
          ],
        ),
      ),
    );
  }
}