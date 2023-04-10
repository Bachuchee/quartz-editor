import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quartz_ide/logic/compile_service.dart';
import 'package:quartz_ide/views/editor/editor.dart';
import 'package:quartz_ide/views/editor/output_window/output_window.dart';

import '../file_tree/file_tree.dart';
import 'control_bar.dart';

class QuartzAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const QuartzAppBar({super.key})
      : preferredSize = const Size.fromHeight(
          kToolbarHeight + 15.0,
        );

  @override
  final Size preferredSize;

  @override
  ConsumerState<QuartzAppBar> createState() => _AppBarState();
}

class _AppBarState extends ConsumerState<QuartzAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _menuController;

  Future<void> setUpMenuController() async {}

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fileTreeState = ref.watch(fileTreeStateProvider);
    final curFile = ref.watch(curFileProvider).curFile;

    return AppBar(
      leading: IconButton(
        tooltip: fileTreeState
            ? "Close file tree (Ctrl+Q)"
            : "Open file tree (Ctrl+Q)",
        icon: AnimatedIcon(
          icon: AnimatedIcons.close_menu,
          progress: fileTreeState
              ? Tween<double>(begin: 0.0, end: 1.0)
                  .animate(_menuController..reverse())
              : Tween<double>(begin: 0.0, end: 1.0).animate(
                  _menuController..forward(),
                ),
        ),
        onPressed: () {
          ref.read(fileTreeStateProvider.notifier).state = !fileTreeState;
        },
      ),
      centerTitle: true,
      title: const ControlBar(),
      actions: [
        IconButton(
          onPressed: curFile != null
              ? () {
                  CompilerService.compile(ref.read(textContentProvider)).then(
                    (value) =>
                        ref.read(compileResultProvider.notifier).state = value,
                  );
                  ref.read(outputWindowStateProvider.notifier).state = true;
                }
              : null,
          padding: const EdgeInsets.all(4.0),
          tooltip: 'Run (Ctrl+R)',
          icon: const Icon(Icons.play_arrow),
          color: Colors.green,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(1.0, 1.0, 8.0, 1.0),
          child: PopupMenuButton(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/amogboy.jpeg',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Divider(
          height: 0.0,
          color: Theme.of(context).colorScheme.primary,
          thickness: 2.0,
        ),
      ),
    );
  }
}
