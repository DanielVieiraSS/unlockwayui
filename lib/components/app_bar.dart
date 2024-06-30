import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

var registerAppBar = (BuildContext context, [VoidCallback? goBack]) {
  return AppBar(
    surfaceTintColor: Colors.transparent,
    leading: TextButton.icon(
      style: const ButtonStyle(
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
      ),
      onPressed: () {
        if (goBack != null) {
          goBack();
        } else {
          Navigator.pop(context);
        }
      },
      icon: Icon(
        Icons.arrow_back,
        size: 26.0,
        color: Theme.of(context).colorScheme.primary,
      ),
      label: Text(
        'Voltar'.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
      ),
    ),
    leadingWidth: 140,
    actions: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SvgPicture.asset(
          "assets/svgs/logo_mini.svg",
          width: 28,
          height: 28,
        ),
      ),
    ],
    automaticallyImplyLeading: true,
    elevation: 0,
    titleSpacing: 0.0,
    backgroundColor: Theme.of(context).colorScheme.surface,
  );
};
