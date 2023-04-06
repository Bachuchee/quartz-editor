import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quartz_ide/views/editor/editor.dart';

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

    return AppBar(
      leading: IconButton(
        tooltip: fileTreeState ? "True" : "False",
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
      title: SizedBox(
        height: 40.0,
        width: 400.0,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Choose a file to edit...',
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
              size: 20.0,
            ),
            border: const OutlineInputBorder(),
          ),
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.bottom,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(4.0),
          tooltip: 'Run',
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
