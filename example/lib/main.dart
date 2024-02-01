import 'package:flutter/material.dart';
import 'package:pagination_scroll_view/pagination_scroll_view.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _itemCount = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination Scroll View Example"),
        centerTitle: true,
      ),
      body: PaginationScrollView(
        key: const Key("pagination_scroll_view"),
        pageChanged: (page) {
          setState(() {
            _itemCount += 20;
          });
        },
        threshold: 0.8,
        scrollOptions: const ScrollOptions(
          physics: BouncingScrollPhysics(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 200,
              color: Colors.red,
              child: const Center(
                child: Text("Header"),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Item $index"),
                );
              },
              itemCount: _itemCount,
            ),
          ],
        ),
      )
    );
  }
}
