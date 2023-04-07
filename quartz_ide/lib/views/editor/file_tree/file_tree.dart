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
  const FileTree(this.fileTree, {super.key});

  final List<StorageNode> fileTree;

  @override
  State<FileTree> createState() => _FileTreeState();
}

class _FileTreeState extends State<FileTree> {
  void deleteNode(StorageNode node, List<StorageNode> curSection) {
    setState(() {
      curSection.remove(node);
    });
  }

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
            () => deleteNode(item, fileTree),
            () {
              showDialog(
                context: context,
                builder: (context) {
                  return NewFileDialog(
                    (fileName, fileType) => addToTree(
                      fileName,
                      fileType,
                      item,
                    ),
                  );
                },
              );
            },
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
            () => deleteNode(item, fileTree),
          ),
        );
      }
    }
  }

  void addToTree(String fileName, FileType fileType, FolderNode? nodeToAddTo) {
    StorageNode newNode = fileType == FileType.folder
        ? FolderNode(fileName, [])
        : FileNode(fileName);
    if (nodeToAddTo != null) {
      setState(() {
        _recursiveAdd(widget.fileTree, nodeToAddTo, newNode);
      });
    } else {
      setState(() {
        widget.fileTree.add(newNode);
      });
    }
  }

  bool _recursiveAdd(
    List<StorageNode> curTree,
    FolderNode nodeToAddTo,
    StorageNode nodeToAdd,
  ) {
    bool isInDir = false;
    for (var item in curTree) {
      if (item is FolderNode) {
        if (item == nodeToAddTo) {
          nodeToAddTo.opened = true;
          nodeToAddTo.children.add(nodeToAdd);
          return true;
        } else {
          item.opened = _recursiveAdd(item.children, nodeToAddTo, nodeToAdd);
          isInDir = item.opened ? true : isInDir;
        }
      }
    }
    return isInDir;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> fileTreeWidget = [];

    buildTree(fileTreeWidget, widget.fileTree, 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 50.0,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 160.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                primary: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: fileTreeWidget,
                ),
              ),
            ),
          ),
        ),
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
                  return NewFileDialog(
                    (fileName, fileType) => addToTree(
                      fileName,
                      fileType,
                      null,
                    ),
                  );
                },
              );
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
      ],
    );
  }
}
