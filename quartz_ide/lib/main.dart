import 'package:flutter/material.dart';
import 'package:quartz_ide/theme/color_scheme.dart';
import 'package:quartz_ide/views/editor/text_section.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quartz IDE',
      theme: ThemeData(
        colorScheme: darkColorScheme,
        fontFamily: 'Sen',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const EditorDemo(),
    );
  }
}

class EditorDemo extends StatefulWidget {
  const EditorDemo({super.key});

  @override
  State<EditorDemo> createState() => _EditorDemoState();
}

class _EditorDemoState extends State<EditorDemo> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TextSection(),
    );
  }
}
