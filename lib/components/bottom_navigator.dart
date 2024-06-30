// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:unlockway/components/navigation.dart';
import 'package:unlockway/screens/history/history.dart';
import 'package:unlockway/screens/home/home.dart';
import 'package:unlockway/screens/meals/meals.dart';
import 'package:unlockway/screens/routine/routine.dart';
import 'package:unlockway/screens/settings/settings.dart';

class UBottomNavigator extends StatelessWidget {
  const UBottomNavigator(this.atual, {super.key});

  final String atual;

  @override
  Widget build(BuildContext context) {
    Color home = Theme.of(context).colorScheme.outline;
    Color meal = Theme.of(context).colorScheme.outline;
    Color routine = Theme.of(context).colorScheme.outline;
    Color settings = Theme.of(context).colorScheme.outline;
    Color history = Theme.of(context).colorScheme.outline;

    if (atual == "Home") {
      home = Theme.of(context).colorScheme.primary;
    } else if (atual == "Meal") {
      meal = Theme.of(context).colorScheme.primary;
    } else if (atual == "Routine") {
      routine = Theme.of(context).colorScheme.primary;
    } else if (atual == "Settings") {
      settings = Theme.of(context).colorScheme.primary;
    } else if (atual == "History") {
      history = Theme.of(context).colorScheme.primary;
    }

    return SizedBox(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        height: 60,
        margin: const EdgeInsets.only(
          bottom: 16,
          left: 16,
          right: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.onSurface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                navigatePage(
                  context,
                  const Home(),
                );
              },
              icon: Icon(
                PhosphorIcons.house(PhosphorIconsStyle.regular),
                size: 28,
                color: home,
              ),
            ),
            IconButton(
              onPressed: () {
                navigatePage(
                  context,
                  const Meals(),
                );
              },
              icon: Icon(
                PhosphorIcons.bowlFood(PhosphorIconsStyle.regular),
                size: 28,
                color: meal,
              ),
            ),
            IconButton(
              onPressed: () async {
                navigatePage(
                  context,
                  const Routine(),
                );
              },
              icon: Icon(
                PhosphorIcons.timer(PhosphorIconsStyle.regular),
                size: 28,
                color: routine,
              ),
            ),
            IconButton(
              onPressed: () {
                navigatePage(
                  context,
                  const History(),
                );
              },
              icon: Icon(
                PhosphorIcons.scroll(PhosphorIconsStyle.regular),
                size: 28,
                color: history,
              ),
            ),
            IconButton(
              onPressed: () {
                navigatePage(
                  context,
                  const Settings(),
                );
              },
              icon: Icon(
                PhosphorIcons.gearSix(PhosphorIconsStyle.regular),
                size: 28,
                color: settings,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
