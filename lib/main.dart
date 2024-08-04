import 'package:flutter/material.dart';
import 'package:practice/views/homepage.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      }));
}
