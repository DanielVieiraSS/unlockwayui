import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unlockway/components/days_list.dart';
import 'package:unlockway/components/navigation.dart';
import 'package:unlockway/constants.dart';
import 'package:unlockway/handlers/routine.handlers.dart';
import 'package:unlockway/models/relations/routine_meal_on_creation.dart';
import 'package:unlockway/screens/routine/components/new_routine_page.dart';

class RoutineCard extends StatelessWidget {
  const RoutineCard({
    super.key,
    required this.name,
    required this.weekRepetitions,
    required this.calories,
    required this.meals,
    required this.color,
    required this.using,
    required this.routineId,
    required this.fetchRoutine,
  });

  final Function() fetchRoutine;
  final String name;
  final List<bool> weekRepetitions;
  final double calories;
  final List<RoutineMealOnCreation> meals;
  final Color color;
  final bool using;
  final String routineId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            navigationPageRightAnimation(
              NewRoutine(
                routineId: routineId,
                name: name,
                meals: meals,
                inUsage: using,
                weekRepetitions: weekRepetitions,
              ),
            ),
          ).then(
            (value) => fetchRoutine,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svgs/calendar.svg",
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              DaysList(
                function: null,
                days: weekRepetitions,
                enable: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ButtonStyle(
                        fixedSize: const WidgetStatePropertyAll(
                          Size(77, 30),
                        ),
                        backgroundColor: using
                            ? const WidgetStatePropertyAll(
                                Color(0XFFF7BEA1),
                              )
                            : const WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                        side: using
                            ? const WidgetStatePropertyAll(
                                BorderSide(
                                  width: 0,
                                  color: Colors.transparent,
                                ),
                              )
                            : WidgetStatePropertyAll(
                                BorderSide(
                                  width: 2,
                                  color: Color(darkBgdark),
                                ),
                              )),
                    onPressed: () {
                      changeUsedRoutine(context, routineId).then(
                        (value) => fetchRoutine(),
                      );
                    },
                    child: Text(
                      using ? "USANDO" : "USAR",
                      style: TextStyle(
                        color:
                            using ? Color(darkBgdark) : const Color(0XFFF39668),
                        fontFamily: "Inter",
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/svgs/Fire.svg"),
                      Text(
                        calories.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE96016),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
