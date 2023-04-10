import 'package:flutter/material.dart';

import 'file_node.dart';

class CurFileNotifier extends ChangeNotifier {
  FileNode? _curFile;

  FileNode? get curFile {
    return _curFile;
  }

  set curFile(FileNode? newFile) {
    _curFile = newFile;
    notifyListeners();
  }

  void updateFileContent(String newContent) {
    if (_curFile != null) {
      _curFile!.content = newContent;
      notifyListeners();
    }
  }
}
