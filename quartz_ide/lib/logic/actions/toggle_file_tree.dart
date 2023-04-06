import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quartz_ide/views/editor/editor.dart';

class ToggleFileTreeIntent extends Intent {
  const ToggleFileTreeIntent(this.riverpodRef);
  final WidgetRef riverpodRef;
}

class ToggleFileTreeAction extends Action {
  @override
  void invoke(covariant ToggleFileTreeIntent intent) {
    intent.riverpodRef.read(fileTreeStateProvider.notifier).state =
        !intent.riverpodRef.read(fileTreeStateProvider);
  }
}
