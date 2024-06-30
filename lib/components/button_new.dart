import 'package:flutter/material.dart';
import 'package:unlockway/constants.dart';

class NewBTN extends StatelessWidget {
  const NewBTN({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Color(primarydark),
        ),
        iconColor: const WidgetStatePropertyAll(Colors.white),
      ),
      iconSize: 24,
      icon: const Icon(Icons.add),
    );
  }
}
