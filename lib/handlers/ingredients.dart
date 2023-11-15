// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unlockway/components/popups.dart';
import 'package:unlockway/components/simple_popup.dart';
import 'package:unlockway/constants.dart';

Future<void> getIngredients(
  BuildContext context,
  String sessionToken,
) async {
  const String apiUrl =
      'https://unlockway.azurewebsites.net/api/v1/ingredients';

  try {
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Authorization': 'Bearer $sessionToken',
      "Content-type": "application/json",
    });

    ingredients = json.decode(response.body);
  } catch (e) {
    modalBuilderBottomAnimation(
      context,
      const SimplePopup(
        message: "Houve um erro na execução do aplicativo",
      ),
    );
  }
}
