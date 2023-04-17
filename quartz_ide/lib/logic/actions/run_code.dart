import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quartz_ide/views/editor/editor.dart';
import 'package:quartz_ide/views/editor/file_tree/file_tree.dart';

import '../../views/editor/output_window/output_window.dart';
import '../compile_service.dart';

class RunCodeIntent extends Intent {
  const RunCodeIntent(this.riverpodRef);
  final WidgetRef riverpodRef;
}

class RunCodeAction extends Action {
  @override
  void invoke(covariant RunCodeIntent intent) {
    if (intent.riverpodRef.read(curFileProvider).curFile != null) {
      CompilerService.compile(intent.riverpodRef.read(textContentProvider))
          .then(
        (value) => intent.riverpodRef
            .read(compileResultProvider.notifier)
            .state = value,
      );
      intent.riverpodRef.read(outputWindowStateProvider.notifier).state = true;
    }
  }
}
