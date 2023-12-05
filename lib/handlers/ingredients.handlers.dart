// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unlockway/constants.dart';
import 'package:unlockway/models/ingredients.dart';

Future<List<IngredientModel>> getIngredientsAPI(BuildContext context) async {
  var sessionToken = userData.token;
  const String apiUrl =
      'https://unlockway.azurewebsites.net/api/v1/ingredients';

  final response = await http.get(Uri.parse(apiUrl), headers: {
    'Authorization': 'Bearer $sessionToken',
    'Accept-Charset': 'UTF-8', // Adicionado Accept-Charset
  });

  if (response.statusCode == 200) {
    // Use o utf8.decode para garantir que a codificação seja interpretada corretamente
    String responseBody = utf8.decode(response.bodyBytes);

    // Agora, você pode decodificar o JSON
    List<dynamic> ingredientsList = json.decode(responseBody);

    // Mapeia os dados para a lista de objetos IngredientModel
    List<IngredientModel> ingredients = ingredientsList.map((ingredient) {
      return IngredientModel.fromMap(ingredient);
    }).toList();

    return ingredients;
  } else {
    // Se a solicitação não foi bem-sucedida, trate o erro (por exemplo, lançar uma exceção)
    throw Exception('Falha na solicitação: ${response.statusCode}');
  }
}

Future<List<IngredientModel>> getIngredientsByNameAPI(
  BuildContext context,
  String name,
) async {
  const String apiUrl =
      'https://unlockway.azurewebsites.net/api/v1/ingredients/findByName';

  final uri = Uri.parse(apiUrl).replace(queryParameters: {
    'userId': userData.id,
    'name': name,
  });

  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer ${userData.token}',
      'Accept-Charset': 'UTF-8', // Adicionado Accept-Charset
    },
  );

  if (response.statusCode == 200) {
    // Use o utf8.decode para garantir que a codificação seja interpretada corretamente
    String responseBody = utf8.decode(response.bodyBytes);

    // Agora, você pode decodificar o JSON
    List<dynamic> ingredientList = json.decode(responseBody);

    // Mapeia os dados para a lista de objetos IngredientModel
    List<IngredientModel> ingredients = ingredientList.map((ingredient) {
      return IngredientModel.fromMap(ingredient);
    }).toList();

    return ingredients;
  } else {
    // Se a solicitação não foi bem-sucedida, trate o erro (por exemplo, lançar uma exceção)
    throw Exception('Falha na solicitação: ${response.statusCode}');
  }
}
