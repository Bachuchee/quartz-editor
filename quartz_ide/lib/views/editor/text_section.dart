import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quartz_ide/theme/color_scheme.dart';
import 'package:rich_text_controller/rich_text_controller.dart';

import 'text_lines.dart';

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
  late RichTextController _controller;
  String _lastText = "";
  int _lineAmount = 1;

  @override
  void initState() {
    super.initState();

    _controller = RichTextController(
      onMatch: (matches) {},
      patternMatchMap: {
        RegExp("^int\$"): const TextStyle(
          color: varKeywordColor,
          fontSize: 24.0,
          fontFamily: 'Sen',
        ),
        RegExp("^bool\$"): const TextStyle(
          color: varKeywordColor,
          fontSize: 24.0,
          fontFamily: 'Sen',
        ),
        RegExp("^char\$"): const TextStyle(
          color: varKeywordColor,
          fontSize: 24.0,
          fontFamily: 'Sen',
        ),
        RegExp("^var\$"): const TextStyle(
          color: varKeywordColor,
          fontSize: 24.0,
          fontFamily: 'Sen',
        ),
        RegExp("^return\$"): const TextStyle(
          color: otherKeywordColor,
          fontSize: 24.0,
          fontFamily: 'Sen',
        ),
        RegExp("^if\$"): const TextStyle(
          color: otherKeywordColor,
          fontSize: 24.0,
          fontFamily: 'Sen',
        ),
        RegExp("^else\$"): const TextStyle(
          color: otherKeywordColor,
          fontSize: 24.0,
          fontFamily: 'Sen',
        ),
        RegExp("^for\$"): const TextStyle(
          color: otherKeywordColor,
          fontSize: 24.0,
          fontFamily: 'Sen',
        ),
        RegExp("^while\$"): const TextStyle(
          color: otherKeywordColor,
          fontSize: 24.0,
          fontFamily: 'Sen',
        ),
        RegExp("^true\$"): const TextStyle(
          color: literalColor,
          fontSize: 24.0,
          fontFamily: 'Sen',
        ),
        RegExp("^false\$"): const TextStyle(
          color: literalColor,
          fontSize: 24.0,
          fontFamily: 'Sen',
        ),
        RegExp("'[aA-zZ]*'"): const TextStyle(
          color: literalColor,
          fontSize: 24.0,
          fontFamily: 'Sen',
        ),
        RegExp("[aA-zZ]+[0-9]*"): const TextStyle(
          color: functionColor,
          fontSize: 24.0,
          fontFamily: 'Sen',
        ),
        RegExp("[0-9]+"): const TextStyle(
          color: literalColor,
          fontSize: 24.0,
          fontFamily: 'Sen',
        ),
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onChange(String text) {}

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: TextLines(_lineAmount),
            ),
            const SizedBox(width: 2.0),
            Expanded(
              flex: 48,
              child: Actions(
                actions: {InsertTabIntent: InsertTabAction()},
                child: Shortcuts(
                  shortcuts: {
                    LogicalKeySet(LogicalKeyboardKey.tab):
                        InsertTabIntent(4, _controller)
                  },
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontFamily: 'Sen',
                    ),
                    maxLines: null,
                    onChanged: (text) {
                      int position = _controller.selection.baseOffset;
                      try {
                        String firstPart =
                            _controller.text.substring(0, position);
                        String secondPart =
                            _controller.text.substring(position);
                        String lastChar = _controller.text[position - 1];
                        if (_controller.text.length > _lastText.length ||
                            _controller.text.isEmpty) {
                          switch (lastChar) {
                            case "'":
                              _controller.text = "$firstPart'$secondPart";
                              _controller.selection = TextSelection.collapsed(
                                offset: position,
                              );
                              break;

                            case '"':
                              _controller.text = '$firstPart"$secondPart';
                              _controller.selection = TextSelection.collapsed(
                                offset: position,
                              );
                              break;

                            case "(":
                              _controller.text = "$firstPart)$secondPart";
                              _controller.selection = TextSelection.collapsed(
                                offset: position,
                              );
                              break;

                            case "{":
                              _controller.text = "$firstPart}$secondPart";
                              _controller.selection = TextSelection.collapsed(
                                offset: position,
                              );
                              break;

                            case "[":
                              _controller.text = "$firstPart]$secondPart";
                              _controller.selection = TextSelection.collapsed(
                                offset: position,
                              );
                              break;
                          }
                        }
                      } catch (e) {}
                      _lastText = _controller.text;
                      setState(() {
                        _lineAmount = _lastText.split('\n').length;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
