import 'dart:html';
import 'package:flutter/material.dart';
import 'package:quartz_ide/views/editor/file_tree/file_tree.dart';
import 'package:quartz_ide/views/editor/text_section/text_section.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorDemoState();
}

class _EditorDemoState extends State<Editor> {
  @override
  void initState() {
    super.initState();
    document.onContextMenu.listen((event) => event.preventDefault());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          Expanded(
            flex: 2,
            child: FileTree(),
          ),
          VerticalDivider(),
          Expanded(
            flex: 18,
            child: TextSection(),
          ),
        ],
      ),
    );
  }
}
