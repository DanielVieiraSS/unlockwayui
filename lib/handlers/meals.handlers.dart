// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:unlockway/components/popups.dart';
import 'package:unlockway/components/simple_popup.dart';
import 'package:unlockway/constants.dart';
import 'package:unlockway/models/ingredients.dart';
import 'package:unlockway/models/meals.dart';

Future<List<MealsModel>> getMealsAPI(
  BuildContext context,
) async {
  const String apiUrl =
      'https://unlockway.azurewebsites.net/api/v1/meals/findByUserId';

  final response = await http.get(
    Uri.parse(apiUrl).replace(queryParameters: {
      'id': userData.id,
    }),
    headers: {
      'Authorization': 'Bearer ${userData.token}',
    },
  );

  List mealList = json.decode(response.body);

  return mealList.map((meal) {
    return MealsModel.fromMap(meal);
  }).toList();
}

Future<void> createMealsAPI(
  BuildContext context,
  String sessionToken,
  String userID,
  String name,
  String category,
  String description,
  String preparationMethod,
  List<SelectedFood> ingredients,
  File? imageFile,
) async {
  const String apiUrl = 'https://unlockway.azurewebsites.net/api/v1/meals';

  var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
    ..headers['Authorization'] = 'Bearer $sessionToken';

  var payload = {
    "userId": userID,
    "name": name,
    "category": category,
    "description": description,
    "preparationMethod": preparationMethod,
    "ingredients": ingredients.map((e) => e.toJson()).toList()
  };

  String payloadEncoded = json.encode(payload);

  request.fields["payload"] = payloadEncoded;

  if (imageFile != null) {
    var imageStream = http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();
    var multipartFile = http.MultipartFile('photo', imageStream, length,
        filename: imageFile.path.split('/').last,
        contentType: MediaType(
          "image",
          imageFile.path.split(".").last,
        ));

    request.files.add(multipartFile);
  }

  await request.send().then(
    (response) {
      if (response.statusCode == 201) {
        modalBuilderBottomAnimation(
          context,
          const SimplePopup(
            message: "Refeição criada com sucesso",
          ),
        );
      }

      if (response.statusCode == 400) {
        modalBuilderBottomAnimation(
          context,
          const SimplePopup(
            message: "Erro ao criar refeição",
          ),
        );
      }
    },
  );
}

Future<void> editMealsAPI(
  BuildContext context,
  String sessionToken,
  String userID,
  String mealID,
  String name,
  String category,
  String description,
  String preparationMethod,
  List<SelectedFood> ingredients,
  File? imageFile,
) async {
  const String apiUrl = 'https://unlockway.azurewebsites.net/api/v1/meals';

  var request = http.MultipartRequest(
    'PUT',
    Uri.parse(apiUrl),
  )..headers['Authorization'] = 'Bearer $sessionToken';

  var payload = {
    "id": mealID,
    "userId": userID,
    "name": name,
    "category": category,
    "description": description,
    "preparationMethod": preparationMethod,
    "ingredients": ingredients.map((e) => e.toJson()).toList()
  };

  String payloadEncoded = json.encode(payload);

  request.fields["payload"] = payloadEncoded;

  if (imageFile != null) {
    var imageStream = http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();
    var multipartFile = http.MultipartFile(
      'photo',
      imageStream,
      length,
      filename: imageFile.path.split('/').last,
      contentType: MediaType(
        "image",
        imageFile.path.split(".").last,
      ),
    );

    request.files.add(multipartFile);
  }

  await request.send().then(
    (response) {
      if (response.statusCode == 201) {
        modalBuilderBottomAnimation(
          context,
          const SimplePopup(
            message: "Refeição editada com sucesso",
          ),
        );
      }

      if (response.statusCode == 400) {
        modalBuilderBottomAnimation(
          context,
          const SimplePopup(
            message: "Erro ao editar refeição",
          ),
        );
      }
    },
  );
}

Future<void> deleteMealAPI(
  BuildContext context,
  String sessionToken,
  String mealID,
) async {
  String apiUrl = 'https://unlockway.azurewebsites.net/api/v1/meals/$mealID';

  final response = await http.delete(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $sessionToken',
    },
  );

  response;
}
