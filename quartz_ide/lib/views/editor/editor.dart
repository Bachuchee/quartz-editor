import 'dart:html';
import 'package:flutter/material.dart';
import 'package:quartz_ide/views/editor/file_tree/file_tree.dart';
import 'package:quartz_ide/views/editor/text_section/text_section.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_bar/app_bar.dart';

final fileTreeStateProvider = StateProvider<bool>((ref) => true);

class Editor extends ConsumerStatefulWidget {
  const Editor({super.key});

  @override
  ConsumerState<Editor> createState() => _EditorDemoState();
}

class _EditorDemoState extends ConsumerState<Editor> {
  @override
  void initState() {
    super.initState();
    document.onContextMenu.listen((event) => event.preventDefault());
  }

  @override
  Widget build(BuildContext context) {
    final fileTreeState = ref.watch(fileTreeStateProvider);

    return Scaffold(
      appBar: const QuartzAppBar(),
      body: Row(
        children: [
          if (fileTreeState)
            Expanded(
              flex: 2,
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                child: const FileTree(),
              ),
            ),
          if (fileTreeState)
            VerticalDivider(
              width: 0.0,
              color: Theme.of(context).colorScheme.primary,
            ),
          const Expanded(
            flex: 18,
            child: TextSection(),
          ),
        ],
      ),
    );
  }
}
