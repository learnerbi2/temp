import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  late final WebViewController _controller;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize WebView
    _initializeController();
  }

  Future<void> _initializeController() async {
   final String fileHtmlContents = await rootBundle.loadString('lib/assets/chatbotpage.html');
    // final String contentBase64 = base64Encode(const Utf8Encoder().convert(fileHtmlContents));

    // final url = Uri.dataFromString(
    //   fileHtmlContents,
    //   mimeType: 'text/html',
    //   encoding: Encoding.getByName('utf-8'),
    //   ).toString();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.dataFromString(
    fileHtmlContents,
    mimeType: 'text/html',
    encoding: Encoding.getByName('utf-8'),
  ));
    setState(() {
      _isControllerInitialized = true; // Mark the controller as initialized
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shakhi.."),
      ),
      body: _isControllerInitialized
          ? WebViewWidget(controller: _controller) // Use WebViewWidget instead of WebView
          : Center(child: CircularProgressIndicator()), // Show progress until controller is ready
    );
  }
}
