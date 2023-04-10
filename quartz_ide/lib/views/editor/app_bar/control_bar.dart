import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quartz_ide/views/editor/editor.dart';
import 'package:quartz_ide/views/editor/file_tree/file_tree.dart';

class ControlBar extends ConsumerStatefulWidget {
  const ControlBar({super.key});

  @override
  ConsumerState<ControlBar> createState() => _ControlBarState();
}

class _ControlBarState extends ConsumerState<ControlBar> {
  late final TextEditingController _controller;
  final barNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    barNode.addListener(() {
      if (!barNode.hasFocus) {
        _controller.text = ref.read(curFileProvider).curFile?.name ?? "";
      } else {
        _controller.text = "";
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final file = ref.watch(curFileProvider).curFile;
    final curContent = ref.watch(textContentProvider);

    _controller.text = file?.name ?? "";

    return SizedBox(
      height: 40.0,
      width: 400.0,
      child: TextField(
        focusNode: barNode,
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Choose a file to edit...',
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.primary,
            size: 20.0,
          ),
          border: const OutlineInputBorder(),
          suffixIcon: file != null && !barNode.hasFocus
              ? IconButton(
                  tooltip: file.content != curContent ? "Save (Ctrl+S)" : null,
                  icon: Icon(
                    file.content != curContent
                        ? Icons.save
                        : Icons.insert_drive_file,
                  ),
                  onPressed: file.content != curContent
                      ? () => ref
                          .read(curFileProvider.notifier)
                          .updateFileContent(curContent)
                      : null,
                )
              : null,
        ),
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.bottom,
        onChanged: (value) {},
      ),
    );
  }
}
