import 'package:flutter/material.dart';
import 'package:unlockway/components/app_bar.dart';
import 'package:unlockway/components/buttons.dart';
import 'package:unlockway/components/days_list.dart';
import 'package:unlockway/components/popups.dart';
import 'package:unlockway/components/text_field.dart';
import 'package:unlockway/constants.dart';
import 'package:unlockway/handlers/meals.handlers.dart';
import 'package:unlockway/handlers/routine.handlers.dart';
import 'package:unlockway/models/meals.dart';
import 'package:unlockway/models/relations/routine_meal_on_creation.dart';
import 'package:unlockway/models/user.dart';
import 'package:unlockway/screens/routine/components/routine_meal_card.dart';
import 'package:unlockway/screens/routine/components/routine_meal_popup.dart';

class NewRoutine extends StatefulWidget {
  const NewRoutine({
    super.key,
    required this.name,
    required this.meals,
    required this.inUsage,
    required this.weekRepetitions,
    required this.routineId,
  });

  final String? name;
  final List<RoutineMealOnCreation> meals;
  final bool? inUsage;
  final List<bool>? weekRepetitions;
  final String? routineId;

  @override
  State<NewRoutine> createState() => _NewRoutineState();
}

class _NewRoutineState extends State<NewRoutine> {
  UserModel user = userData;

  List<MealsModel> mealsList = [];
  bool _isLoading = true;

  final nameController = TextEditingController();
  List<RoutineMealOnCreation> mealsSelectedToRoutine = [];
  List<bool> daysSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  void fetchAllMeals() async {
    var result = await getMealsAPI(context);

    setState(() {
      mealsList = result;
      _isLoading = false;
    });
  }

  changeDays(int dayID) {
    daysSelected[dayID] = !daysSelected[dayID];
  }

  saveToRoutineMeals(String idMeal, String notifyAt) {
    setState(() {
      mealsSelectedToRoutine.add(
        RoutineMealOnCreation(idMeal: idMeal, notifyAt: notifyAt),
      );
    });
  }

  removeFromRoutineMeals(int index) {
    setState(() {
      mealsSelectedToRoutine.removeAt(index);
    });
  }

  editFromRoutineMeals(String idMeal, String notifyAt, int index) {
    setState(() {
      mealsSelectedToRoutine[index] =
          RoutineMealOnCreation(idMeal: idMeal, notifyAt: notifyAt);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllMeals();
    if (widget.name != null) {
      nameController.text = widget.name!;
      daysSelected = widget.weekRepetitions!;
      mealsSelectedToRoutine = widget.meals;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10),
          child: widget.name != null
              ? Row(
                  children: [
                    ButtonOutlined(
                      text: "EXCLUIR ROTINA",
                      height: 48,
                      width: double.infinity,
                      onTap: () {
                        deleteRoutineAPI(
                          context,
                          user.token!,
                          widget.routineId!,
                        );
                      },
                      color: Color(danger),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ButtonFilled(
                      text: "EDITAR ROTINA",
                      height: 48,
                      width: double.infinity,
                      onTap: () {
                        editRoutineAPI(
                          context,
                          nameController.text,
                          widget.inUsage!,
                          mealsSelectedToRoutine,
                          daysSelected,
                          widget.routineId!,
                        );
                      },
                    ),
                  ],
                )
              : Row(
                  children: [
                    ButtonFilled(
                      text: "CRIAR ROTINA",
                      height: 48,
                      width: double.infinity,
                      onTap: () {
                        createRoutineAPI(
                          context,
                          user.id!,
                          user.token!,
                          nameController.text,
                          false,
                          mealsSelectedToRoutine,
                          daysSelected,
                        );
                      },
                    ),
                  ],
                )),
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: registerAppBar(context),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      GenericTextField(
                        title: "Nome",
                        placeholder: "Insira um nome para a rotina",
                        width: double.infinity,
                        controller: nameController,
                        number: false,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Selecione os dias que a rotina deve ocorrer",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ),
                          DaysList(
                            days: daysSelected,
                            enable: true,
                            function: (int dayID) {
                              changeDays(dayID);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                (() {
                  if (_isLoading) {
                    return SliverToBoxAdapter(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: constraints.maxHeight - 20,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  } else {
                    return SliverToBoxAdapter(
                      child: mealsSelectedToRoutine.isNotEmpty
                          ? ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: constraints.maxHeight - 20,
                              ),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 1.8,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                shrinkWrap: true,
                                itemCount: mealsSelectedToRoutine.length,
                                itemBuilder: (context, index) {
                                  List<MealsModel> filteredMeal = mealsList
                                      .where((element) =>
                                          element.id ==
                                          mealsSelectedToRoutine[index].idMeal)
                                      .toList();

                                  return RoutineMealCard(
                                    index: index,
                                    mealId: filteredMeal[0].id,
                                    editMethod: (String idMeal, String notifyAt,
                                        int index) {
                                      editFromRoutineMeals(
                                          idMeal, notifyAt, index);
                                    },
                                    removeMethod: (int index) {
                                      removeFromRoutineMeals(index);
                                    },
                                    category: filteredMeal[0].category,
                                    meal: filteredMeal[0].name,
                                    hour: mealsSelectedToRoutine[index]
                                        .notifyAt
                                        .toString(),
                                    mealsList: mealsList,
                                    calories: filteredMeal[0].totalCalories,
                                    imgURL: filteredMeal[0].photo != null
                                        ? filteredMeal[0].photo as String
                                        : "",
                                  );
                                },
                              ),
                            )
                          : const Text(""),
                    );
                  }
                })(),
                SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {
                        modalBuilderBottomAnimation(
                          context,
                          RoutineMealPopup(
                            index: null,
                            mealId: null,
                            category: '',
                            hour: TimeOfDay.now(),
                            selectedMeal: '',
                            mealsList: mealsList,
                            editMethod:
                                (String idMeal, String notifyAt, int index) {
                              editFromRoutineMeals(
                                idMeal,
                                notifyAt,
                                index,
                              );
                            },
                            saveMethod: (String idMeal, String notifyAt) {
                              saveToRoutineMeals(
                                idMeal,
                                notifyAt,
                              );
                            },
                            removeMethod: (int index) {
                              removeFromRoutineMeals(
                                index,
                              );
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: Text(
                        "Novo",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: ButtonStyle(
                        iconColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.primary,
                        ),
                        iconSize: const WidgetStatePropertyAll(16),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
