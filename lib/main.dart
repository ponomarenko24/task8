
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

List<int> items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: Text("TODO List"),
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 150,
              margin: EdgeInsets.all(20),
              color: Colors.amber,
              child: Center(child: Text("data ${items[index]}")),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              items.insert(0, 100);
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
