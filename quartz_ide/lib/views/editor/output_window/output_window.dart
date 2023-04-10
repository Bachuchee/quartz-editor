import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quartz_ide/logic/compile_service.dart';

final compileResultProvider = StateProvider<CompileResult?>((ref) => null);

class OutputWindow extends ConsumerStatefulWidget {
  const OutputWindow({super.key, this.onClose});

  final void Function()? onClose;

  @override
  ConsumerState<OutputWindow> createState() => _OutputWindowState();
}

class _OutputWindowState extends ConsumerState<OutputWindow> {
  @override
  Widget build(BuildContext context) {
    final result = ref.watch(compileResultProvider);

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width * 0.2,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Output",
                  style: TextStyle(
                    fontSize: 20.0,
                    textBaseline: TextBaseline.alphabetic,
                    fontFamily: "Sen",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: widget.onClose,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const Divider(),
          const Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
                child: SelectableText(
                  "Output from compiler:",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "ModeNine",
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 8.0),
                child: SelectableText(
                  result?.compileResult ?? "",
                  style: TextStyle(
                    color: result?.isError ?? false ? Colors.red : Colors.blue,
                    fontSize: 16.0,
                    fontFamily: "ModeNine",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
