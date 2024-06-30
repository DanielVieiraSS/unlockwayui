import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:unlockway/components/app_bar.dart';
import 'package:unlockway/components/buttons.dart';
import 'package:unlockway/components/navigation.dart';
import 'package:unlockway/components/text_field.dart';
import 'package:unlockway/constants.dart';
import 'package:unlockway/handlers/meals.handlers.dart';
import 'package:unlockway/models/ingredients.dart';
import 'package:unlockway/models/user.dart';
import 'package:unlockway/screens/meals/components/foods_selection_page.dart';
import 'package:dotted_border/dotted_border.dart';

class NewMeal extends StatefulWidget {
  const NewMeal({
    super.key,
    required this.id,
    required this.category,
    required this.selectedFoods,
    required this.name,
    required this.preparationMethod,
    required this.description,
    required this.selectedImage,
  });

  final String id;
  final String category;
  final List selectedFoods;
  final String name;
  final String preparationMethod;
  final String description;
  final File selectedImage;

  @override
  State<NewMeal> createState() => _NewMealState();
}

class _NewMealState extends State<NewMeal> {
  @override
  void initState() {
    super.initState();
  }

  UserModel user = userData;
  final List<String> selectedFoods = [];

  String selectedImagePath = '';
  final categoriaController = TextEditingController();
  final nomeController = TextEditingController();
  final descriptionController = TextEditingController();
  final preparationMethodController = TextEditingController();
  List<Object> ingredients = [];
  String? category;
  List<SelectedFood> ingredientsSelected = [];
  double ingredientsTotalCalories = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            ButtonOutlined(
              color: Color(danger),
              text: "EXCLUIR",
              height: 48,
              width: double.infinity,
              onTap: () {
                deleteMealAPI(
                  context,
                  user.token!,
                  widget.id,
                );
              },
            ),
            const SizedBox(
              width: 15,
            ),
            ButtonFilled(
              text: "SALVAR",
              height: 48,
              width: double.infinity,
              onTap: () {
                createMealsAPI(
                  context,
                  user.token!,
                  user.id!,
                  nomeController.text,
                  category!,
                  descriptionController.text,
                  preparationMethodController.text,
                  ingredientsSelected,
                  selectedImagePath != '' ? File(selectedImagePath) : null,
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: registerAppBar(context),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  mealPhotoModal(
                    context,
                  );
                },
                child: selectedImagePath != ''
                    ? Container(
                        width: double.infinity,
                        height: 158,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onSurface,
                            width: 2,
                          ),
                        ),
                        child: Image.file(
                          File(selectedImagePath),
                          fit: BoxFit.fitHeight,
                          width: double.infinity,
                          height: 158,
                        ),
                      )
                    : DottedBorder(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(6),
                        dashPattern: const [10, 10],
                        strokeWidth: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 158,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                PhosphorIcons.camera(
                                    PhosphorIconsStyle.regular),
                                size: 94.0,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              Text(
                                "Escolha uma imagem",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Inter",
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              GenericTextField(
                title: "Nome",
                placeholder: "Insira o nome da refeição",
                width: double.infinity,
                controller: nomeController,
                number: false,
              ),
              const SizedBox(height: 20),
              Text(
                "Categoria",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16,
                  fontFamily: "Inter",
                ),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                child: DropdownButton<String>(
                  dropdownColor: Theme.of(context).colorScheme.onSurface,
                  hint: const Text("EX: Almoço"),
                  borderRadius: BorderRadius.circular(6),
                  isExpanded: true,
                  value: category,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: 16,
                    fontFamily: "Inter",
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      category = newValue!;
                    });
                  },
                  underline: Container(
                    color: Colors.transparent,
                  ),
                  items: <String>[
                    'Café da manhã',
                    'Almoço',
                    'Jantar',
                    'Lanche',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(
                    navigationPageRightAnimation(
                      FoodSelectionPage(ingredients: ingredientsSelected),
                    ),
                  )
                      .then(
                    (value) {
                      if (value.isNotEmpty) {
                        setState(
                          () {
                            ingredientsTotalCalories = 0;
                            ingredientsSelected = value;
                          },
                        );
                      }
                    },
                  );
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: ingredientsSelected.isNotEmpty
                        ? Theme.of(context).colorScheme.primary
                        : Color(darker),
                  ),
                  child: Center(
                    child: ingredientsSelected.isNotEmpty
                        ? Text(
                            "${ingredientsSelected.length} Ingredientes",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Inter",
                            ),
                          )
                        : const Text(
                            "ESCOLHER INGREDIENTES",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Inter",
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFieldMultline(
                title: "Descrição",
                placeholder: "Insira o nome da refeição",
                width: double.infinity,
                controller: descriptionController,
              ),
              const SizedBox(height: 20),
              TextFieldMultline(
                controller: preparationMethodController,
                title: "Modo de Preparo",
                placeholder:
                    "Escreva ou cole aqui o modo de preparo de sua refeição",
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  pickFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  Future<void> mealPhotoModal(BuildContext context) async {
    return showModalBottomSheet<void>(
      enableDrag: true,
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
        return Column(
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
            Container(
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      selectedImagePath = await pickFromCamera();

                      if (selectedImagePath != '') {
                        setState(() {});
                      } else {}
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 95,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              PhosphorIcons.camera(PhosphorIconsStyle.regular),
                              size: 60.0,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Tirar Foto",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () async {
                      selectedImagePath = await pickFromGallery();

                      if (selectedImagePath != '') {
                        setState(() {});
                      } else {}
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 95,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              PhosphorIcons.images(PhosphorIconsStyle.regular),
                              size: 60.0,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Foto da Galeria",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
