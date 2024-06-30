import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:unlockway/components/popups.dart';

class PendingActions extends StatelessWidget {
  const PendingActions({
    super.key,
    required this.meals,
    required this.routines,
  });

  final int meals;
  final int routines;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        modalBuilderBottomAnimation(
          context,
          PendingPopup(meals: meals, routines: routines),
        );
      },
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(6),
          color: Theme.of(context).colorScheme.onSurface,
        ),
        padding: const EdgeInsets.all(6),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                PhosphorIcons.warningCircle(PhosphorIconsStyle.regular),
                size: 32.0,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                child: Text(
                  "Você tem ações pendentes",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 19,
                    color: Theme.of(context).colorScheme.outline,
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

class PendingPopup extends StatelessWidget {
  const PendingPopup({
    super.key,
    required this.meals,
    required this.routines,
  });

  final int meals;
  final int routines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                PhosphorIcons.checkCircle(PhosphorIconsStyle.regular),
                size: 45.0,
                color: meals == 0
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                width: 15,
              ),
              Icon(
                PhosphorIcons.bowlFood(PhosphorIconsStyle.regular),
                size: 30.0,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(
                width: 6,
              ),
              const Expanded(
                child: Text(
                  "Crie sua primeira refeição",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Icon(
                PhosphorIcons.checkCircle(PhosphorIconsStyle.regular),
                size: 45.0,
                color: routines == 0
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                width: 15,
              ),
              Icon(
                PhosphorIcons.timer(PhosphorIconsStyle.regular),
                size: 30.0,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(
                width: 6,
              ),
              const Expanded(
                child: Text(
                  "Crie sua primeira rotina",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Inter",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
