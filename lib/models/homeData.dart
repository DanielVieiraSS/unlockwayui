class HomeDataModel {
  const HomeDataModel({
    required this.meals,
    required this.routines,
    required this.notifications,
    required this.weekCalories,
  });

  final int meals;
  final int routines;
  final int notifications;
  final List<double?> weekCalories;

  factory HomeDataModel.fromMap(Map<String, dynamic> map) {
    // Converting the dynamic list to List<double?>
    List<dynamic> weekCaloriesDynamic = map['weekCalories'];
    List<double?> weekCaloriesList = weekCaloriesDynamic.map((calorie) {
      if (calorie == null) {
        return null;
      } else {
        return (calorie as num).toDouble();
      }
    }).toList();

    return HomeDataModel(
      meals: map['meals'],
      routines: map['routines'],
      notifications: map['notifications'],
      weekCalories: weekCaloriesList,
    );
  }
}
