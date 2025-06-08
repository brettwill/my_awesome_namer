import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;
  List<dynamic> todos = [];

  Future<void> fetchTodos() async {
    final userId = supabase.auth.currentUser!.id;
    final response = await supabase
        .from('todos')
        .select()
        .eq('user_id', userId);
    setState(() {
      todos = response;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Todos')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo['title']),
            trailing: Icon(
              todo['is_complete'] ? Icons.check_circle : Icons.circle_outlined,
              color: todo['is_complete'] ? Colors.green : Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
