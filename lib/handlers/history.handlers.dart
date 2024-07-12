// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unlockway/components/popups.dart';
import 'package:unlockway/components/simple_popup.dart';
import 'package:unlockway/constants.dart';
import 'package:unlockway/models/history.dart';

Future<List<HistoryModel>> getHistoryAPI(BuildContext context) async {
  // var sessionToken = userData.token;
  String apiUrl = 'http://localhost:8080/history/get';

  final response = await http.get(Uri.parse(apiUrl), headers: {
    //  'Authorization': 'Bearer $sessionToken',
    //  'Accept-Charset': 'UTF-8', // Adicionado Accept-Charset
  });

  if (response.statusCode == 200) {
    // Use o utf8.decode para garantir que a codificação seja interpretada corretamente
    String responseBody = utf8.decode(response.bodyBytes);

    // Agora, você pode decodificar o JSON
    List<dynamic> historyList = json.decode(responseBody);
    // Mapeia os dados para a lista de objetos HistoryModel
    List<HistoryModel> history = historyList.map((history) {
      return HistoryModel.fromMap(history);
    }).toList();

    return history;
  } else {
    // Se a solicitação não foi bem-sucedida, trate o erro (por exemplo, lançar uma exceção)
    throw Exception('Falha na solicitação: ${response.statusCode}');
  }
}

Future<void> getHistoryIngestedAPI(
  BuildContext context,
  String routineId,
  String ingestedMealId,
) async {
  String apiUrl = 'https://unlockway.azurewebsites.net/api/v1/history/ingested';

  final response = await http.put(
    Uri.parse(apiUrl).replace(queryParameters: {
      'routine': routineId,
      'meal': ingestedMealId,
    }),
    headers: {
      'Authorization': 'Bearer ${userData.token}',
      'Accept-Charset': 'UTF-8', // Adicionado Accept-Charset
    },
  );

  if (response.statusCode == 200) {
    modalBuilderBottomAnimation(
      context,
      SimplePopup(
        message: utf8.decode(response
            .bodyBytes), // Use utf8.decode para interpretar corretamente
      ),
    );
  }
  if (response.statusCode == 400) {
    modalBuilderBottomAnimation(
      context,
      const SimplePopup(
        message: "Ocorreu um erro",
      ),
    );
  }
}
