import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final supabase = Supabase.instance.client;
  List<dynamic> todos = [];
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Future<void> fetchTodos() async {
  //   // final userId = supabase.auth.currentUser!.id;
  //   final response = await supabase.from('todos').select()
  //   // .eq('user_id', userId)
  //   ;
  //   setState(() {
  //     todos = response;
  //   });
  // }

  // final Map<String, String> _validUsers = {
  //   'alice': 'password123',
  //   'bob': 'qwerty',
  //   'charlie': 'letmein',
  //   'brett': 'brett',
  //   'c': '',
  // };

  String? _errorMessage;

  Future<void> _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // final response = await Supabase.instance.client.from('users').select();

    // if (response.isNotEmpty && response[0]['password'] == 'password123X') {
    //   print(response[0]['password']);
    // }

    final response = await Supabase.instance.client
        .from('users')
        .select('id') // Select only a lightweight field
        .ilike('username', username)
        .eq('password', password)
        .limit(1); // Only check for existence

    bool userExists = response.isNotEmpty;

    if (userExists == true) {
      context.pushReplacement('/home/$username');
    } else {
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchTodos();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome', style: Theme.of(context).textTheme.displayLarge),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(hintText: 'Username'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(hintText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                child: const Text('ENTER'),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
