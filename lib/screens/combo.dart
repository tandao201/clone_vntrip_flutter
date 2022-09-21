import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Combo extends StatelessWidget {
  static const routeName = '/combo';

  @override
  Widget build(BuildContext context) {
    void clickCancel() {
      Navigator.pop(context);
    }

    late WebViewController webController;

    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (await webController.canGoBack()) {
                      webController.goBack();
                    } else {
                      clickCancel();
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Combo',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    clickCancel();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: 'https://donggia.vntrip.vn/',
                onWebViewCreated: (controller) {
                  webController = controller;
                },
              )
          )
        ],
      ),
      ),
    );
  }
}