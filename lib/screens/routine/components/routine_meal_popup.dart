import 'package:flutter/material.dart';
import 'package:unlockway/components/buttons.dart';
import 'package:unlockway/constants.dart';
import 'package:unlockway/models/meals.dart';

class RoutineMealPopup extends StatefulWidget {
  const RoutineMealPopup({
    super.key,
    required this.index,
    required this.mealId,
    required this.saveMethod,
    required this.removeMethod,
    required this.editMethod,
    required this.mealsList,
    required this.category,
    required this.hour,
    required this.selectedMeal,
  });

  final int? index;
  final String? mealId;
  final Function? saveMethod;
  final Function(int index) removeMethod;
  final Function(String idMeal, String notifyAt, int index) editMethod;
  final String? selectedMeal;
  final String category;
  final TimeOfDay hour;

  final List<MealsModel> mealsList;

  @override
  State<RoutineMealPopup> createState() => _RoutineMealPopupState();
}

class _RoutineMealPopupState extends State<RoutineMealPopup> {
  String? selectedMeal;
  String category = "BREAKFAST";
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    if (widget.mealId != null) {
      category = widget.category;
      selectedMeal = widget.mealId;
      selectedTime = widget.hour;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<MealsModel> mealsOptions = widget.mealsList
        .where((element) => element.category == category)
        .toList();

    return Container(
      margin: const EdgeInsets.all(20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                items: const [
                  DropdownMenuItem(
                    value: 'BREAKFAST',
                    child: Text('Café da manhã'),
                  ),
                  DropdownMenuItem(
                    value: 'LUNCH',
                    child: Text('Almoço'),
                  ),
                  DropdownMenuItem(
                    value: 'DINNER',
                    child: Text('Jantar'),
                  ),
                  DropdownMenuItem(
                    value: 'SNACK',
                    child: Text('Lanche'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Refeição",
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
                hint: const Text(""),
                value: selectedMeal,
                borderRadius: BorderRadius.circular(6),
                isExpanded: true,
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
                    selectedMeal = newValue!;
                  });
                },
                underline: Container(
                  color: Colors.transparent,
                ),
                items: mealsOptions.map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Horário",
              style: TextStyle(
                color: Theme.of(context).colorScheme.outline,
                fontSize: 16,
                fontFamily: "Inter",
              ),
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () async {
                final timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                  initialEntryMode: TimePickerEntryMode.dial,
                );
                if (timeOfDay != null) {
                  setState(() {
                    selectedTime = timeOfDay;
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                width: double.infinity,
                height: 60,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}",
                    // Adiciona um zero à esquerda se necessário
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: 16,
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            widget.saveMethod == null
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ButtonOutlined(
                        text: "EXCLUIR",
                        height: 48,
                        width: double.infinity,
                        onTap: () {
                          widget.removeMethod(widget.index!);
                          Navigator.pop(
                            context,
                          );
                        },
                        color: Color(danger),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ButtonFilled(
                        text: "EDITAR",
                        height: 48,
                        width: double.infinity,
                        onTap: () {
                          widget.editMethod(
                            selectedMeal!,
                            _timeOfDayToString(selectedTime),
                            widget.index!,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ButtonOutlined(
                        text: "CANCELAR",
                        height: 48,
                        width: double.infinity,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ButtonFilled(
                        text: "SALVAR",
                        height: 48,
                        width: double.infinity,
                        onTap: () {
                          widget.saveMethod!(
                            selectedMeal,
                            _timeOfDayToString(selectedTime),
                          );
                          Navigator.pop(
                            context,
                          );
                        },
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  String _timeOfDayToString(TimeOfDay timeOfDay) {
    var time = timeOfDay.toString().substring(10);
    var finalTime = time.split(")");
    return finalTime[0];
  }
}
