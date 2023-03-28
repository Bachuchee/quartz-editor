import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quartz_ide/theme/color_scheme.dart';
import 'package:rich_text_controller/rich_text_controller.dart';

// for tabs

class InsertTabIntent extends Intent {
  const InsertTabIntent(this.numSpaces, this.textController);
  final int numSpaces;
  final TextEditingController textController;
}

class InsertTabAction extends Action {
  @override
  Object invoke(covariant Intent intent) {
    if (intent is InsertTabIntent) {
      final oldValue = intent.textController.value;
      final newComposing = TextRange.collapsed(oldValue.composing.start);
      final newSelection = TextSelection.collapsed(
          offset: oldValue.selection.start + intent.numSpaces);

      final newText = StringBuffer(oldValue.selection.isValid
          ? oldValue.selection.textBefore(oldValue.text)
          : oldValue.text);
      for (var i = 0; i < intent.numSpaces; i++) {
        newText.write(' ');
      }
      newText.write(oldValue.selection.isValid
          ? oldValue.selection.textAfter(oldValue.text)
          : '');
      intent.textController.value = intent.textController.value.copyWith(
        composing: newComposing,
        text: newText.toString(),
        selection: newSelection,
      );
    }
    return '';
  }
}

class TextSection extends StatefulWidget {
  const TextSection({super.key});

  @override
  State<TextSection> createState() => _TextSectionState();
}

class _TextSectionState extends State<TextSection> {
  late RichTextController _contoller;

  @override
  void initState() {
    super.initState();

    _contoller = RichTextController(
      onMatch: (matches) {},
      stringMatchMap: {
        "int": const TextStyle(color: varKeywordColor),
        "bool": const TextStyle(color: varKeywordColor),
        "char": const TextStyle(color: varKeywordColor),
        "var": const TextStyle(color: varKeywordColor),
        'return': const TextStyle(color: functionColor),
        'aaaaaaaaaaaa': const TextStyle(color: Colors.white),
      },
    );
  }

  @override
  void dispose() {
    _contoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Actions(
        actions: {InsertTabIntent: InsertTabAction()},
        child: Shortcuts(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.tab):
                InsertTabIntent(2, _contoller)
          },
          child: TextField(
            controller: _contoller,
            decoration: InputDecoration(border: null),
            maxLines: null,
          ),
        ),
      ),
    );
  }
}
