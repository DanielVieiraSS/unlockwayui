import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unlockway/themes/theme_manager.dart';

String theme = "dark";

class ThemeDialog extends StatefulWidget {
  const ThemeDialog({super.key});

  @override
  State<ThemeDialog> createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.onSurface,
      ),
      height: 200,
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RadioListTile(
            title: Text(
              "MODO CLARO",
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontFamily: "Inter",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            value: "light",
            groupValue: theme,
            onChanged: (value) {
              setState(() {
                theme = value.toString();
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme(value.toString());
                Navigator.of(context).pop();
              });
            },
          ),
          RadioListTile(
            selected: theme == "dark" ? true : false,
            title: Text(
              "MODO ESCURO",
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontFamily: "Inter",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            value: "dark",
            groupValue: theme,
            onChanged: (value) {
              setState(() {
                theme = value.toString();
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme(value.toString());
                Navigator.of(context).pop();
              });
            },
          ),
        ],
      ),
    );
  }
}

Future<void> themeModal(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return const Dialog(
        alignment: Alignment.center,
        insetPadding: EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: ThemeDialog(),
      );
    },
  );
}
