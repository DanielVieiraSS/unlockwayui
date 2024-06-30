import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unlockway/components/app_bar.dart';
import 'package:unlockway/components/days_list.dart';

import 'package:unlockway/models/relations/history_meal.dart';
import 'package:unlockway/screens/history/components/meal_history_card.dart';

class HistoryDetails extends StatelessWidget {
  const HistoryDetails({
    super.key,
    required this.ingestedMeals,
    required this.days,
    required this.name,
    required this.color,
    required this.calories,
  });

  final List<HistoryMealOnGet> ingestedMeals;
  final List days;
  final String name;
  final Color color;
  final double? calories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: registerAppBar(context),
      body: Container(
          margin: const EdgeInsets.all(10),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            child: Text(
                              name,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Dias de Uso",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline,
                                        ),
                                      ),
                                    ),
                                    DaysList(
                                      function: null,
                                      days: days,
                                      enable: false,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Calorias Acumuladas",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Inter",
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/svgs/Fire.svg"),
                                            Text(
                                              calories.toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFE96016),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(maxHeight: constraints.maxHeight),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 3.2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        shrinkWrap: true,
                        itemCount: ingestedMeals.length,
                        itemBuilder: (context, index) {
                          HistoryMealOnGet actualHistory = ingestedMeals[index];

                          return MealHistoryCard(
                            title: actualHistory.name,
                            description: actualHistory.description,
                            img: actualHistory.photo,
                            ingested: actualHistory.ingested,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
