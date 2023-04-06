import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quartz_ide/theme/color_scheme.dart';
import 'package:quartz_ide/views/editor/editor.dart';
import 'package:quartz_ide/views/editor/text_section/text_section.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quartz',
      theme: ThemeData(
        colorScheme: darkColorScheme,
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: darkColorScheme.surface,
          ),
          textStyle: TextStyle(
            color: darkColorScheme.onSurface,
          ),
        ),
        fontFamily: 'Sen',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Editor(),
    );
  }
}
