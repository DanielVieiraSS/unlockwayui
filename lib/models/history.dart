import 'package:unlockway/models/relations/history_meal.dart';

class HistoryModel {
  const HistoryModel({
    required this.idRoutine,
    required this.routineName,
    required this.calories,
    required this.date,
    required this.ingestedMeals,
    required this.days,
  });

  final String idRoutine;
  final String routineName;
  final double calories;
  final String date;
  final List<HistoryMealOnGet> ingestedMeals;
  final Map days;

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    List historyMeals = map['ingestedMeals'];
    return HistoryModel(
      idRoutine: map['idRoutine'],
      routineName: map['routineName'],
      calories: map['calories'],
      date: map['date'],
      ingestedMeals: historyMeals.map((e) {
        return HistoryMealOnGet(
          id: e['id'],
          idMeal: e['idMeal'],
          idRoutineMeal: e['idRoutineMeal'],
          ingested: e['ingested'],
          name: e['name'],
          photo: e['photo'],
          description: e['description'],
          category: e['category'],
          totalCalories: e['totalCalories'],
        );
      }).toList(),
      days: map['days'],
    );
  }
}
