import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:new_goverment_app/Utils/List/List.dart';
import 'package:new_goverment_app/golbal/global.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Engine"),
        actions: [
          IconButton(
            onPressed: () {
              PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "Bookmark",
                    child: Row(
                      children: [
                        Icon(Icons.book),
                        SizedBox(
                          width: 20,
                        ),
                        Text("All Books"),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: "search",
                    child: Row(
                      children: [
                        Icon(Icons.screen_search_desktop_outlined),
                        SizedBox(
                          width: 20,
                        ),
                        Text("All Books"),
                      ],
                    ),
                  ),
                ],
                initialValue: popmenu,
                onSelected: (value) {
                  if (value == "search") {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (context, _, __) => Material(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListView.builder(
                            itemBuilder: (context, index) => RadioListTile(
                                value: list_engine[index]['val'],
                                groupValue: "Google",
                                onChanged: (val) {
                                  setState(() {
                                    list_engine[index][val] = val;
                                    Navigator.of(context).pushNamed(
                                        'search_engine',
                                        arguments: list_engine[index]);
                                  });
                                }),
                          ),
                        ),
                      ),
                    );
                  }
                },
              );
            },
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) =>
            (snapshot.data == ConnectivityResult.mobile)
                ? Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            "Select a Platform :",
                            style: TextStyle(
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: ListView.builder(
                          itemCount: list_engine.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('search_page',
                                  arguments: list_engine[index]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.all(16),
                              height: 100,
                              width: 100,
                              child: Image.network(
                                list_engine[index]['gif'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text("Check Internet Connection bro..."),
                        SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(),
                      ],
                    ),
                  ),
      ),
    );
  }
}
