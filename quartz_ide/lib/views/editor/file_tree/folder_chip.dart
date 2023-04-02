import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../logic/file_node.dart';

class FolderChip extends StatefulWidget {
  const FolderChip(this.folder, this.depth, this.onSelect, {super.key});

  final int depth;
  final FolderNode folder;
  final void Function(bool value) onSelect;

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
          FilterChip(
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
        ],
      ),
    );
  }
}
