import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unlockway/components/navigation.dart';
import 'package:unlockway/models/ingredients.dart';
import 'package:unlockway/screens/meals/components/meal_form.dart';

class UCard extends StatelessWidget {
  const UCard({
    super.key,
    required this.description,
    required this.title,
    this.subtitle,
    required this.imageURL,
    required this.idMeal,
    required this.ingredients,
    required this.category,
    required this.preparationMethod,
    required this.onEdit,
  });

  final String description;
  final String title;
  final String? subtitle;
  final String? imageURL;
  final String idMeal;
  final String category;
  final String preparationMethod;
  final List<SelectedFood> ingredients;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          navigationPageRightAnimation(
            MealForm(
              id: idMeal,
              name: title,
              category: category,
              description: description,
              preparationMethod: preparationMethod,
              ingredientsSelected: ingredients,
              img: imageURL,
              onSave: onEdit,
            ),
          ),
        );
      },
      child: Container(
        width: 177,
        height: 288,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: imageURL == null
                  ? Container(
                      height: 125,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: imageURL!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 125,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 6.00),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 200,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: "Signika",
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: 19.02,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      subtitle ?? "",
                      style: const TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 14.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(top: 8.0, bottom: 5.0),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    textAlign: TextAlign.left,
                    description,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    maxLines: 3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
