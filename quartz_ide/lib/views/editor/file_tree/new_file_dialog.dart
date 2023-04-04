import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../logic/file_node.dart';

enum FileType {
  quartz,
  folder,
}

const List<IconData> fileIcons = [
  Icons.insert_drive_file,
  Icons.folder,
];

class NewFileDialog extends StatefulWidget {
  const NewFileDialog(this.onCreate, {super.key});

  final void Function(
    String fileName,
    FileType fileType,
  ) onCreate;

  @override
  State<NewFileDialog> createState() => _NewFileDialogState();
}

class _NewFileDialogState extends State<NewFileDialog> {
  FileType? _fileType;
  String _fileName = "";

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "New File",
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        label: Text("Name"),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (name) => _fileName = name,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Type:",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    DropdownButton<FileType>(
                      value: _fileType,
                      items: FileType.values
                          .map<DropdownMenuItem<FileType>>(
                            (val) => DropdownMenuItem<FileType>(
                              value: val,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(fileIcons[val.index]),
                                  ),
                                  Text(val.name),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) => setState(() => _fileType = val),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 24.0, 4.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _fileType != null && _fileName.isNotEmpty
                            ? () {
                                widget.onCreate(_fileName, _fileType!);
                                Navigator.pop(context);
                              }
                            : null,
                        child: const Text("Create"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                        ),
                        child: const Text("Cancel"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
