import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MealHistoryCard extends StatelessWidget {
  const MealHistoryCard({
    super.key,
    required this.title,
    required this.description,
    required this.img,
    required this.ingested,
  });

  final String title;
  final String description;
  final String? img;
  final bool ingested;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.onSurface,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          img == null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                    ),
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: img!,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
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
                const SizedBox(
                  height: 6,
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
            ingested ? "assets/svgs/ok.svg" : "assets/svgs/no.svg",
            height: 40,
            width: 40,
          ),
        ],
      ),
    );
  }
}
