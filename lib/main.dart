import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainApp(),
    );
  }
}

List<String> items = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  final TextEditingController _controller = TextEditingController();

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
          onPressed: () => dialogWindow(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _addTask() {
    final text = _controller.text.trim();
    setState(() {
      items.insert(0, text);
    });
  }

  Future<String?> dialogWindow(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder:
          (BuildContext context) => Dialog(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 30),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: "Enter task here"),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _addTask();
                          _controller.clear();
                        },
                        child: const Text('Add'),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
