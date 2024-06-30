import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unlockway/components/app_bar.dart';
import 'package:unlockway/components/buttons.dart';

import 'package:unlockway/constants.dart';
import 'package:unlockway/handlers/ingredients.handlers.dart';
import 'package:unlockway/models/ingredients.dart';
import 'package:unlockway/models/user.dart';
import 'package:unlockway/screens/meals/components/food_card.dart';

class FoodSelectionPage extends StatefulWidget {
  const FoodSelectionPage({
    super.key,
    required this.ingredients,
  });

  final List<SelectedFood> ingredients;

  @override
  State<FoodSelectionPage> createState() => _FoodSelectionPageState();
}

class _FoodSelectionPageState extends State<FoodSelectionPage> {
  UserModel user = userData;
  Timer? _debounceTimer;
  List<IngredientModel> ingredientsList = [];
  bool _isLoading = true;

  List<SelectedFood> selectedIngredients = [];
  final searchController = TextEditingController();

  void fetchAllIngredients() async {
    var result = await getIngredientsAPI(context);

    setState(() {
      ingredientsList = result;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllIngredients();
    if (widget.ingredients.isNotEmpty) {
      selectedIngredients = widget.ingredients;
    }
  }

  @override
  void dispose() {
    super.dispose();
    ingredientsList = [];
    _isLoading = true;
  }

  void toggleIngredient(String id, double amount) {
    int index = findSelectedFoodById(id);
    if (index != -1) {
      setState(() {
        selectedIngredients.removeAt(index);
      });
    } else {
      setState(() {
        selectedIngredients.add(SelectedFood(id, amount));
      });
    }
  }

  int findSelectedFoodById(String id) {
    for (int i = 0; i < selectedIngredients.length; i++) {
      if (selectedIngredients[i].id == id) {
        return i;
      }
    }
    return -1;
  }

  sumOrSubValues(double value, IngredientModel selectedFood) {
    selectedIngredients = selectedIngredients.map((e) {
      if (e.id == selectedFood.id) {
        e.amount = value;
        return e;
      }
      return e;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          bottom: 16,
          left: 16,
          right: 16,
          top: 6,
        ),
        child: Row(
          children: [
            ButtonFilled(
              text: "ESCOLHER",
              height: 48,
              width: double.infinity,
              onTap: () {
                Navigator.pop(
                  context,
                  selectedIngredients,
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
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                _onTextChanged(value);
                              },
                              cursorColor:
                                  const Color.fromARGB(255, 155, 155, 155),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              decoration: InputDecoration(
                                enabled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor:
                                    Theme.of(context).colorScheme.onSurface,
                                contentPadding: const EdgeInsets.all(10.0),
                                hintText: "Buscar",
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
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
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Selecione os ingredientes",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: 19,
                            fontFamily: "Inter",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                _isLoading
                    ? SliverToBoxAdapter(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight: constraints.maxHeight - 140),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: constraints.maxHeight - 140,
                          ),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 2.3,
                            ),
                            shrinkWrap: true,
                            itemCount: ingredientsList.length,
                            itemBuilder: (context, index) {
                              var currentIngredient = ingredientsList[index];
                              bool selected = false;
                              double initialValue = 0.0;

                              if (widget.ingredients.isNotEmpty) {
                                var filteredIngredients = widget.ingredients
                                    .where((e) => e.id == currentIngredient.id)
                                    .toList();

                                if (filteredIngredients.length == 1) {
                                  selected = true;
                                  initialValue = filteredIngredients[0].amount;
                                }
                              }

                              return IngredientCard(
                                initialValue: initialValue,
                                food: currentIngredient,
                                checked: selected,
                                onSelectIngredient: (id, amount) {
                                  setState(() {
                                    toggleIngredient(
                                        currentIngredient.id, amount);
                                  });
                                },
                                onSumOrSubAmount: sumOrSubValues,
                              );
                            },
                          ),
                        ),
                      )
              ],
            );
          },
        ),
      ),
    );
  }

  void _onTextChanged(String value) {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      List<IngredientModel> resultName =
          await getIngredientsByNameAPI(context, value);
      setState(() {
        ingredientsList = resultName;
      });
    });
  }
}
