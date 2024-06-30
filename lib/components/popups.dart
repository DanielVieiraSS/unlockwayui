import 'package:flutter/material.dart';

Future<void> modalBuilderBottomAnimation(
  BuildContext context,
  Widget dialog,
) {
  return showModalBottomSheet<void>(
    enableDrag: true,
    isScrollControlled: true,
    context: context,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 180,
              height: 6,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            dialog,
          ],
        ),
      );
    },
  );
}
