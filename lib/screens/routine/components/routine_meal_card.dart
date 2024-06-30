import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:unlockway/components/popups.dart';
import 'package:unlockway/constants.dart';
import 'package:unlockway/models/meals.dart';
import 'package:unlockway/screens/routine/components/routine_meal_popup.dart';

class RoutineMealCard extends StatelessWidget {
  const RoutineMealCard({
    super.key,
    required this.index,
    required this.mealId,
    required this.category,
    required this.meal,
    required this.hour,
    required this.calories,
    required this.imgURL,
    required this.removeMethod,
    required this.editMethod,
    required this.mealsList,
  });

  final int? index;
  final String? mealId;
  final String category;
  final String meal;
  final String hour;
  final double calories;
  final String? imgURL;
  final Function(int index)? removeMethod;
  final Function editMethod;
  final List<MealsModel> mealsList;

  @override
  Widget build(BuildContext context) {
    String categoryText = "";

    if (category == "LUNCH") {
      categoryText = "Almoço";
    }
    if (category == "BREAKFAST") {
      categoryText = "Café da manhã";
    }
    if (category == "DINNER") {
      categoryText = "Jantar";
    }

    if (category == "SNACK") {
      categoryText = "Lanche";
    }
    return InkWell(
      onTap: () {
        List<String> selectedHour = hour.split(':');

        modalBuilderBottomAnimation(
          context,
          RoutineMealPopup(
            index: index,
            mealId: mealId,
            selectedMeal: meal,
            category: category,
            hour: TimeOfDay(
              hour: int.parse(selectedHour[0]),
              minute: int.parse(
                selectedHour[1],
              ),
            ),
            editMethod: (String idMeal, String notifyAt, int index) {
              editMethod(
                idMeal,
                notifyAt,
                index,
              );
            },
            saveMethod: null,
            removeMethod: (int index) {
              removeMethod!(index);
            },
            mealsList: mealsList,
          ),
        );
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 111,
              height: 145,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: imgURL == null || imgURL == ""
                    ? Container(
                        color: Theme.of(context).colorScheme.surface,
                        width: 111,
                        height: 145,
                      )
                    : CachedNetworkImage(
                        imageUrl: imgURL!,
                        fit: BoxFit.fitHeight,
                        width: 111,
                        height: 145,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/forkKnife.svg",
                        width: 26,
                        height: 26,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        categoryText,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontFamily: "Inter",
                          fontSize: 19.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PhosphorIcon(
                        PhosphorIcons.bowlFood(PhosphorIconsStyle.regular),
                        color: Color(success),
                        size: 26,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Text(
                          meal,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontFamily: "Inter",
                            fontSize: 19.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/Timer.svg",
                        width: 26,
                        height: 26,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        hour,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontFamily: "Inter",
                          fontSize: 19.2,
                        ),
                      ),
                      const Spacer(),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
