import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  WebViewController webcontroller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          print("$url is loading");
        },
      ),
    )
    ..loadRequest(Uri.parse('https://google.com'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: webcontroller,
      ),
    );
  }
}
