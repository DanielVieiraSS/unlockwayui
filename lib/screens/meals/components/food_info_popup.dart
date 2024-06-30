import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FoodInfoPopup extends StatelessWidget {
  const FoodInfoPopup({
    super.key,
    required this.calories,
    required this.proteins,
    required this.water,
    required this.fats,
    required this.vitamins,
    required this.imgURL,
    required this.description,
    required this.name,
  });

  final double calories;
  final double proteins;
  final double water;
  final double fats;
  final String vitamins;
  final String imgURL;
  final String description;
  final String name;

  @override
  Widget build(BuildContext context) {
    List<String> vitaminList = vitamins.split(",");

    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 106,
                width: 106,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  child: Image.network(
                    imgURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: 22,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      maxLines: 3,
                      description,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: 14,
                        fontFamily: "Inter",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Calorias: ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                PhosphorIcons.fire(PhosphorIconsStyle.regular),
                size: 16.0,
                color: const Color(0XFFE96016),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                calories.toInt().toString(),
                style: const TextStyle(
                  color: Color(0XFFE96016),
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Proteinas: ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                PhosphorIcons.egg(PhosphorIconsStyle.regular),
                size: 16.0,
                color: const Color(0XFFD49E2B),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                proteins.toInt().toString(),
                style: const TextStyle(
                  color: Color(0XFFD49E2B),
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Água: ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                PhosphorIcons.drop(PhosphorIconsStyle.regular),
                size: 16.0,
                color: const Color(0XFF1FB3F2),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                water.toInt().toString(),
                style: const TextStyle(
                  color: Color(0XFF1FB3F2),
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Gorduras: ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                PhosphorIcons.scales(PhosphorIconsStyle.regular),
                size: 16.0,
                color: const Color(0XFFFAA2A2),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                fats.toInt().toString(),
                style: const TextStyle(
                  color: Color(0XFFFAA2A2),
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Vitaminas:",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    vitaminList.length,
                    (i) {
                      return Container(
                        width: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onSurface,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(50),
                            right: Radius.circular(50),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            vitaminList[i].replaceAll(' ', ''),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: 16,
                              fontFamily: "Inter",
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
