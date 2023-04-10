import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quartz_ide/views/editor/editor.dart';
import 'package:quartz_ide/views/editor/file_tree/file_tree.dart';

class SaveFileIntent extends Intent {
  const SaveFileIntent(this.riverpodRef);
  final WidgetRef riverpodRef;
}

class SaveFileAction extends Action {
  @override
  void invoke(covariant SaveFileIntent intent) {
    if (intent.riverpodRef.read(curFileProvider).curFile != null) {
      final content = intent.riverpodRef.read(textContentProvider);
      intent.riverpodRef
          .read(curFileProvider.notifier)
          .updateFileContent(content);
    }
  }
}
