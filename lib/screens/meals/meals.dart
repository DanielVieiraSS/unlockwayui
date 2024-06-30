import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:unlockway/components/bottom_navigator.dart';
import 'package:unlockway/components/navigation.dart';
import 'package:unlockway/constants.dart';
import 'package:unlockway/handlers/meals.handlers.dart';
import 'package:unlockway/models/ingredients.dart';
import 'package:unlockway/models/meals.dart';
import 'package:unlockway/screens/meals/components/meal_card.dart';
import 'package:unlockway/screens/meals/components/meal_form.dart';

class Meals extends StatefulWidget {
  const Meals({super.key});

  @override
  State<Meals> createState() => _MealsState();
}

class _MealsState extends State<Meals> {
  TextEditingController searchController = TextEditingController();
  List<MealsModel> meals = [];
  bool _isLoading = true;
  Timer? _debounceTimer;

  Future<void> fetchMeals() async {
    List<MealsModel> result = await getMealsAPI(context);

    setState(() {
      meals = result;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    _debounceTimer?.cancel();
    _isLoading = false;
    meals = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            navigationPageRightAnimation(
              MealForm(
                id: '',
                category: '',
                description: '',
                ingredientsSelected: const [],
                name: '',
                preparationMethod: '',
                img: null,
                onSave: () {
                  fetchMeals();
                },
              ),
            ),
          );
        },
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Color(primarydark),
          ),
          iconColor:
              WidgetStatePropertyAll(Theme.of(context).colorScheme.outline),
        ),
        iconSize: 24,
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: const UBottomNavigator("Meal"),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: SafeArea(
          child: Container(
            margin:
                const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "REFEIÇÕES",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Inter",
                        color: Theme.of(context).colorScheme.outline),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                        onChanged: (value) {
                          _onTextChanged(value);
                        },
                        cursorColor: const Color.fromARGB(255, 155, 155, 155),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        decoration: InputDecoration(
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.onSurface,
                          contentPadding: const EdgeInsets.all(10.0),
                          hintText: "Buscar",
                          suffixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 40,
        ),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : meals.isNotEmpty
                ? LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return CustomScrollView(
                        slivers: <Widget>[
                          SliverToBoxAdapter(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxHeight: constraints.maxHeight),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.850,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                shrinkWrap: true,
                                itemCount: meals.length,
                                itemBuilder: (context, index) {
                                  MealsModel actualMeal = meals[index];
                                  List<SelectedFood> selectedingredients =
                                      actualMeal.ingredients.map((e) {
                                    return SelectedFood(
                                      e.id,
                                      e.amount,
                                    );
                                  }).toList();
                                  return UCard(
                                    description: actualMeal.description,
                                    title: actualMeal.name,
                                    imageURL: actualMeal.photo,
                                    category: actualMeal.category,
                                    idMeal: actualMeal.id,
                                    ingredients: selectedingredients,
                                    preparationMethod:
                                        actualMeal.preparationMethod,
                                    onEdit: fetchMeals,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        PhosphorIcons.bowlFood(PhosphorIconsStyle.regular),
                        size: 150,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 28,
                        ),
                        child: SizedBox(
                          child: Text(
                            textAlign: TextAlign.center,
                            "Não há refeições criadas, crie sua primeira refeição para que ela seja listada aqui.",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontFamily: "Inter",
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  void _onTextChanged(String value) {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      List<MealsModel> resultName = await getMealsByNameAPI(context, value);
      setState(() {
        meals = resultName;
      });
    });
  }
}
