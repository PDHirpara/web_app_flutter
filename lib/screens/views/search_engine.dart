import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import '../../Provider/list_provider.dart';
import '../../Utils/List/List.dart';


class search_engine extends StatefulWidget {
  const search_engine({super.key});

  @override
  State<search_engine> createState() => _search_engineState();
}

class _search_engineState extends State<search_engine> {
  InAppWebViewController? inAppWebViewController;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> engine =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text(engine['name']),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ],
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(engine['url'])),
        onLoadStart: (controller, uri) {
          inAppWebViewController = controller;
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              await inAppWebViewController?.loadUrl(
                urlRequest: URLRequest(
                  url: Uri.parse(engine['url']),
                ),
              );
            },
            heroTag: "home",
            child: Icon(Icons.home),
          ),
          FloatingActionButton(
            onPressed: () async {
              Provider.of<list_book>(context).add_mark(await inAppWebViewController?.getUrl());
            },
            heroTag: "bookmark",
            child: const Icon(Icons.bookmark_add),
          ),
          FloatingActionButton(
            onPressed: () async {
              if (await inAppWebViewController!.canGoBack()) {
                inAppWebViewController?.goBack();
              }
            },
            heroTag: "back",
            child: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          FloatingActionButton(
            onPressed: () async {
              await inAppWebViewController?.reload();
            },
            heroTag: "refresh",
            child: const Icon(Icons.refresh),
          ),
          FloatingActionButton(
            onPressed: () async {
              if (await inAppWebViewController!.canGoForward()) {
                inAppWebViewController?.goForward();
              }
            },
            heroTag: "forward",
            child: const Icon(Icons.arrow_forward_ios_outlined),
          ),
        ],
      ),
    );
  }
}