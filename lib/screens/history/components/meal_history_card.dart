import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MealHistoryCard extends StatelessWidget {
  const MealHistoryCard({
    super.key,
    required this.svg,
    required this.title,
    required this.description,
    required this.img,
  });

  final String svg;
  final String title;
  final String description;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.onBackground,
        border: Border.all(
          color: Theme.of(context).colorScheme.onBackground,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              img,
              width: 80,
              height: 80,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontFamily: "Inter",
                    fontSize: 23.04,
                  ),
                ),
                Text(
                  description,
                  maxLines: 2,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.outline,
                    fontFamily: "Inter",
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          SvgPicture.asset(
            svg,
            height: 32,
            width: 32,
          ),
        ],
      ),
    );
  }
}
