// Step 1: Ensure provider is added in pubspec.yaml

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/retrofit/api.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoListModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List'),
        ),
        body: TodoList(),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  TodoList({super.key});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _textController = TextEditingController(text: 'new-todo-item');
  
  @override
  void initState() {
    final TodoListModel model = Provider.of<TodoListModel>(context, listen: false);
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initTodoItems(model);
    });
    super.initState();
  }

  _initTodoItems(TodoListModel model) async {
    final client = TodoApiClient(Dio());
    final response = await client.getTodos();
    
    model.setTodoItems(response.todos.map((x) => x.todo).toList());
  }

  @override
  Widget build(BuildContext context) {
    final TodoListModel model = Provider.of<TodoListModel>(context, listen: true);
    
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Enter a to-do item',
            ),
            onSubmitted: (value) {
              Provider.of<TodoListModel>(context, listen: false).addTodoItem(value);
            },
          ),
        ),
        Text(model.counter.toString()),
        Expanded(
          child: Consumer<TodoListModel>(
            builder: (context, model, child) {
              return ListView.builder(
                itemCount: model.todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(model.todos[index]),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class TodoListModel extends ChangeNotifier {
  final List<String> _todos = [];
  final String _text = '';

  List<String> get todos => _todos;
  String get text => _text;
  int get counter => _todos.length;

  void addTodoItem(String item) {
    if (item.isNotEmpty) {
      _todos.add(item);
      notifyListeners();
    }
  }

  void setTodoItems(List<String> items) {
    for(var item in items) {
      if (item.isNotEmpty) {
        _todos.add(item);
      }
    }
    notifyListeners();
  }
}