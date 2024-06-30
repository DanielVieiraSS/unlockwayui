import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NoRoutineCard extends StatelessWidget {
  const NoRoutineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 177,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).colorScheme.onSurface,
        border: Border.all(
          color: const Color(0xFF586274),
        ),
      ),
      child: Row(
        children: [
          Icon(
            PhosphorIcons.bowlFood(PhosphorIconsStyle.regular),
            size: 64,
            color: const Color(0xFF586274),
          ),
          const SizedBox(
            width: 6,
          ),
          Expanded(
            child: Text(
              "Você ainda não tem rotinas criadas. Crie sua primeira rotina para ser exibida aqui",
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontSize: 16,
                fontFamily: "Inter",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
