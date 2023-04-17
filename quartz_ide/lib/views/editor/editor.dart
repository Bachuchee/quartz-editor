import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quartz_ide/logic/actions/close_window.dart';
import 'package:quartz_ide/logic/actions/run_code.dart';
import 'package:quartz_ide/logic/actions/save_file.dart';
import 'package:quartz_ide/views/editor/file_tree/file_tree.dart';
import 'package:quartz_ide/views/editor/no_file_selected/no_file_page.dart';
import 'package:quartz_ide/views/editor/output_window/output_window.dart';
import 'package:quartz_ide/views/editor/text_section/text_section.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../logic/actions/toggle_file_tree.dart';
import '../../logic/file_node.dart';
import 'app_bar/app_bar.dart';

final fileTreeStateProvider = StateProvider<bool>((ref) => true);
final outputWindowStateProvider = StateProvider<bool>((_) => false);
final textContentProvider = StateProvider<String>((_) => "");

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

  final List<StorageNode> _fileTree = [];

  @override
  Widget build(BuildContext context) {
    final fileTreeState = ref.watch(fileTreeStateProvider);
    final outputWindowState = ref.watch(outputWindowStateProvider);
    final curFile = ref.watch(curFileProvider).curFile;

    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyQ):
            ToggleFileTreeIntent(ref),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyS):
            SaveFileIntent(ref),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyR):
            RunCodeIntent(ref),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyC):
            CloseWindowIntent(ref),
      },
      child: Actions(
        actions: {
          ToggleFileTreeIntent: ToggleFileTreeAction(),
          SaveFileIntent: SaveFileAction(),
          RunCodeIntent: RunCodeAction(),
          CloseWindowIntent: CloseWindowAction(),
        },
        child: FocusScope(
          autofocus: true,
          child: Scaffold(
            appBar: const QuartzAppBar(),
            body: Row(
              children: [
                if (fileTreeState)
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Theme.of(context).colorScheme.surface,
                      child: FileTree(_fileTree),
                    ),
                  ),
                if (fileTreeState)
                  VerticalDivider(
                    width: 0.0,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                Expanded(
                  flex: 18,
                  child: Stack(
                    children: [
                      if (curFile != null)
                        const TextSection()
                      else
                        const NoFilePage(),
                      if (outputWindowState)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: OutputWindow(
                            onClose: () => ref
                                .read(outputWindowStateProvider.notifier)
                                .state = false,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
