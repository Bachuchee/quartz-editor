import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:quartz_ide/views/editor/file_tree/new_file_dialog.dart';

import '../../../logic/file_node.dart';

class FolderChip extends StatefulWidget {
  const FolderChip(
    this.folder,
    this.depth,
    this.onSelect,
    this.onDelete,
    this.onNew, {
    super.key,
  });

  final int depth;
  final FolderNode folder;
  final void Function(bool value) onSelect;
  final void Function() onDelete;
  final void Function() onNew;

  @override
  State<FolderChip> createState() => _FolderChipState();
}

class _FolderChipState extends State<FolderChip> {
  @override
  Widget build(BuildContext context) {
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
                  onTap: () {
                    Future.delayed(Duration(seconds: 0), () => widget.onNew());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.add),
                      Text("new"),
                    ],
                  ),
                ),
                PopupMenuDivider() as PopupMenuEntry,
                PopupMenuItem(
                  onTap: widget.onDelete,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
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
                ),
              ],
            ),
            child: FilterChip(
              label: Text(widget.folder.name),
              selected: widget.folder.opened,
              onSelected: widget.onSelect,
              selectedColor: Theme.of(context).colorScheme.surfaceVariant,
              showCheckmark: false,
              avatar: widget.folder.opened
                  ? Icon(
                      Icons.folder_open,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : Icon(
                      Icons.folder,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
