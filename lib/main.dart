//import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/screens/real.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://hcxgahxwswlctumniwpz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhjeGdhaHh3c3dsY3R1bW5pd3B6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk0MTQxNDgsImV4cCI6MjA2NDk5MDE0OH0.wb4P6D-9fA4Ekr8A7JhbfMYbFqY3DDIr3NSFboOqAoE',
  );
  runApp(DogHumanMatchApp());
}
