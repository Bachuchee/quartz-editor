import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quartz_ide/views/editor/editor.dart';
import 'package:quartz_ide/views/editor/file_tree/file_tree.dart';

class CloseWindowIntent extends Intent {
  const CloseWindowIntent(this.riverpodRef);
  final WidgetRef riverpodRef;
}

class CloseWindowAction extends Action {
  @override
  void invoke(covariant CloseWindowIntent intent) {
    if (intent.riverpodRef.read(outputWindowStateProvider)) {
      intent.riverpodRef.read(outputWindowStateProvider.notifier).state = false;
    }
  }
}
