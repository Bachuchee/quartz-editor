import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:quartz_ide/views/editor/file_tree/file_chip.dart';
import 'package:quartz_ide/views/editor/file_tree/folder_chip.dart';
import 'package:quartz_ide/views/editor/file_tree/new_file_dialog.dart';
import 'package:riverpod/riverpod.dart';

import '../../../logic/file_node.dart';

final curFileProvider = StateProvider<FileNode?>((ref) => null);

class FileTree extends StatefulWidget {
  const FileTree({super.key});

  @override
  State<FileTree> createState() => _FileTreeState();
}

class _FileTreeState extends State<FileTree> {
  final List<StorageNode> _fileTree = [
    FolderNode('Sugoma', [
      FolderNode('hello', [
        FolderNode('bye', [FolderNode('hi')])
      ]),
      FileNode('hi')
    ]),
    FolderNode('Hello', [FolderNode('sus')]),
  ];

  void buildTree(
    List<Widget> treeWidget,
    List<StorageNode> fileTree,
    int depth,
  ) {
    for (var item in fileTree) {
      if (item is FolderNode) {
        treeWidget.add(
          FolderChip(
            item,
            depth,
            (value) => setState(() => item.opened = !item.opened),
          ),
        );
        if (item.opened) {
          buildTree(treeWidget, item.children, depth + 1);
        }
      } else if (item is FileNode) {
        treeWidget.add(
          FileChip(
            item,
            depth,
          ),
        );
      }
    }
  }

  void addToTree(String fileName, FileType fileType) {
    StorageNode newNode =
        fileType == FileType.folder ? FolderNode(fileName) : FileNode(fileName);
    setState(() {
      _fileTree.add(newNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> fileTreeWidget = [];

    buildTree(fileTreeWidget, _fileTree, 0);

    fileTreeWidget.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return NewFileDialog(addToTree);
                });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.add),
              Text(
                "New",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      primary: true,
      child: SizedBox(
        width: 200.0,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: fileTreeWidget,
        ),
      ),
    );
  }
}
