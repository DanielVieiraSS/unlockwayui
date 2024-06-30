import 'package:flutter/material.dart';

class SettingsOption extends StatelessWidget {
  const SettingsOption({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.borderRadius,
    this.suffix,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  final Color? iconColor;
  final BorderRadius? borderRadius;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.only(top: 1.0),
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: borderRadius,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(icon,
                  color: iconColor ?? Theme.of(context).colorScheme.outline),
              const SizedBox(width: 16.0),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
