import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quartz_ide/views/editor/file_tree/file_tree.dart';
import '../../../logic/file_node.dart';

class FileChip extends ConsumerStatefulWidget {
  const FileChip(this.file, this.depth, {super.key});

  final FileNode file;
  final int depth;

  @override
  ConsumerState<FileChip> createState() => _FileChipState();
}

class _FileChipState extends ConsumerState<FileChip> {
  @override
  Widget build(BuildContext context) {
    FileNode? curFile = ref.watch(curFileProvider);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          SizedBox(width: 24.0 * widget.depth + 2.0),
          FilterChip(
            label: Text(widget.file.name),
            selected: curFile == widget.file,
            onSelected: (isSelected) {
              if (isSelected) {
                ref.read(curFileProvider.notifier).state = widget.file;
              } else {
                ref.read(curFileProvider.notifier).state = null;
              }
            },
            avatar: Icon(
              Icons.insert_drive_file,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
