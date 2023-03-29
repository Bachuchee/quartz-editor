import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextLines extends StatefulWidget {
  const TextLines(this.lineAmount, {super.key});

  final int lineAmount;

  @override
  State<TextLines> createState() => _TextLinesState();
}

class _TextLinesState extends State<TextLines> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.lineAmount < 1 ? 1 : widget.lineAmount,
        itemBuilder: (context, curLine) => Padding(
          padding: const EdgeInsets.all(0.5),
          child: Text(
            '${curLine + 1}',
            style: TextStyle(
              fontSize: 24.0,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
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
