import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.close();
    _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      flutterWebViewPlugin.evalJavascript('alert("onUrlChanged, url: $url");');
    });
  }

  @override
  Widget build(BuildContext context) {
    const String url = 'https://tw.yahoo.com/';
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double bottomBarHeight = height * 10 / 120;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double webViewHeight = height - statusBarHeight - bottomBarHeight;

    flutterWebViewPlugin.launch(url,
        rect: Rect.fromLTWH(0.0, statusBarHeight, width, webViewHeight));

    return Container(
        child: Column(children: <Widget>[
      Expanded(flex: 15, child: Container(color: const Color(0xFFFFFFFF))),
      const Expanded(flex: 95, child: SizedBox()),
      Expanded(
          flex: 10,
          child: Image.asset('assets/icon_bottom_bar.png',
              width: width, fit: BoxFit.fill))
    ]));
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }
}
