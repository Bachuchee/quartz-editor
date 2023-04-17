import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NoFilePage extends StatelessWidget {
  const NoFilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - kToolbarHeight - 15.0,
        color: Theme.of(context).colorScheme.surface,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (MediaQuery.of(context).size.height > 700.0 &&
                  MediaQuery.of(context).size.width > 100.0)
                Image.asset(
                  'assets/images/Quartz-Logo.png',
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "Choose a file to edit...\n",
                      ),
                      TextSpan(
                        text: "Ctrl+Q ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: "to toggle file tree"),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                    fontSize: 24.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
