import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MainApp());
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
        body: taskList(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () => dialogWindow(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget taskList(context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return dismissSwipe(item, index);
      },
    );
  }

  Widget dismissSwipe(item, index) {
    return Dismissible(
      key: Key(item),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          items.removeAt(index);
        });
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: taskContainer(index),
    );
  }

bool? isChecked = false;

  Widget taskContainer(index) {
    return Container(
      height: 150,
      margin: EdgeInsets.all(20),
      color: Colors.amber,
      child: Row(
        children: [
          Text(" ${items[index]}"),
          Checkbox(value: isChecked, onChanged: (bool? value)  {
            setState(() {
              isChecked = value;
            });
          })
        ],
      ),
    );
  }

  void _addTask() {
    final text = _controller.text.trim();
    setState(() {
      items.insert(0, text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
