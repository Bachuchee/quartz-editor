import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quartz_ide/views/editor/file_tree/file_tree.dart';
import '../../../logic/file_node.dart';

class FileChip extends ConsumerStatefulWidget {
  const FileChip(this.file, this.depth, this.onDelete, {super.key});

  final FileNode file;
  final int depth;

  final void Function() onDelete;

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
          GestureDetector(
            onSecondaryTapDown: (details) => showMenu(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              position: RelativeRect.fromLTRB(
                details.globalPosition.dx,
                details.globalPosition.dy,
                details.globalPosition.dx,
                details.globalPosition.dy,
              ),
              items: [
                PopupMenuItem(
                  onTap: widget.onDelete,
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      Text(
                        "Delete",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            child: FilterChip(
              label: Text(
                widget.file.name,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
              showCheckmark: false,
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
          ),
        ],
      ),
    );
  }
}
