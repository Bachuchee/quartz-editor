import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quartz_ide/views/editor/text_section/text_section.dart';

class TextLines extends ConsumerStatefulWidget {
  const TextLines(this.curLine, {super.key});

  final int curLine;

  @override
  ConsumerState<TextLines> createState() => _TextLinesState();
}

class _TextLinesState extends ConsumerState<TextLines> {
  @override
  Widget build(BuildContext context) {
    final lineAmount = ref.watch(lineAmountProvider);

    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: lineAmount < 1 ? 1 : lineAmount,
        itemBuilder: (context, curLine) => Padding(
          padding: const EdgeInsets.all(0.5),
          child: Text(
            '${curLine + 1}',
            style: TextStyle(
              fontSize: 24.0,
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(widget.curLine == curLine ? 1.0 : 0.3),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.end,
          ),
        ),
      ),
    );
  }
}
