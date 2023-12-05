import 'package:flutter/material.dart';
import 'package:unlockway/components/buttons.dart';
import 'package:unlockway/components/popups.dart';
import 'package:unlockway/constants.dart';

class HomeMealCard extends StatelessWidget {
  const HomeMealCard({
    super.key,
    required this.method,
    required this.description,
    required this.category,
    required this.hour,
    required this.imageUrl,
    required this.mealId,
    required this.routineId,
  });

  final String description;
  final String imageUrl;
  final String? hour;
  final String category;
  final String mealId;
  final String routineId;
  final Function(String routineId, String mealId) method;

  @override
  Widget build(BuildContext context) {
    String actualCategory = "";
    if (category == 'BREAKFAST') {
      actualCategory = "Café";
    }
    if (category == 'LUNCH') {
      actualCategory = 'Almoço';
    }
    if (category == 'DINNER') {
      actualCategory = 'Jantar';
    }
    if (category == 'SNACK') {
      actualCategory = 'Lanche';
    }
    List actualHour = hour!.split(":00");

    return InkWell(
      onTap: () {
        modalBuilderBottomAnimation(
          context,
          ConsumeMealDialog(
            method: (String routineId, String mealId) {
              method(routineId, mealId);
            },
            mealId: mealId,
            routineId: routineId,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 177,
        height: 219,
        padding: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 130,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 13.00),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    actualHour[0],
                    style: TextStyle(
                      fontFamily: "Signika",
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: 19.02,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      actualCategory,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontFamily: "Inter",
                        fontSize: 16.0,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  description,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Theme.of(context).colorScheme.background,
                    fontSize: 12,
                    fontFamily: "Inter",
                  ),
                  textAlign: TextAlign.left,
                  maxLines: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConsumeMealDialog extends StatelessWidget {
  const ConsumeMealDialog({
    super.key,
    required this.mealId,
    required this.routineId,
    required this.method,
  });

  final String mealId;
  final String routineId;
  final Function(
    String routineId,
    String mealId,
  ) method;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Você irá consumir essa refeição?",
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 18,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonOutlined(
                text: "NÃO",
                height: 48,
                width: double.infinity,
                onTap: () {
                  Navigator.pop(context);
                },
                color: Color(danger),
              ),
              const SizedBox(
                width: 20,
              ),
              ButtonFilled(
                  text: "SIM",
                  height: 48,
                  width: double.infinity,
                  onTap: () {
                    method(
                      routineId,
                      mealId,
                    );
                    Navigator.pop(context);
                  }),
            ],
          )
        ],
      ),
    );
  }
}
