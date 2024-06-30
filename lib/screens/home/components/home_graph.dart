import 'package:flutter/material.dart';
import 'package:unlockway/constants.dart';
import 'package:unlockway/screens/home/components/bar.dart';
import 'package:unlockway/screens/home/components/line.dart';

class HomeGraph extends StatelessWidget {
  const HomeGraph({
    super.key,
    required this.data,
  });

  final List data;

  @override
  Widget build(BuildContext context) {
    num totalSum = data.fold(0, (sum, element) => sum + (element ?? 0));
    num seventyFivePercent = totalSum * 0.75;
    num twentyFivePercent = totalSum * 0.25;

    List percentageList = [];

    for (var number in data) {
      if (number != null) {
        double percentage = (number / totalSum) * 160;
        percentageList.add(percentage);
      } else {
        percentageList.add(null);
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      alignment: Alignment.bottomCenter,
      height: 200,
      child: Stack(
        children: [
          Positioned.fill(
            left: 0,
            top: -80,
            child: Line(number: seventyFivePercent),
          ),
          Positioned.fill(
            left: 0,
            top: 50,
            child: Line(number: twentyFivePercent),
          ),
          Row(
            children: [
              const SizedBox(
                width: 22.5,
              ),
              const VerticalDivider(
                color: Color(0xFF5A6478),
                endIndent: 25,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Bar(
                      data: data[0],
                      height: percentageList[0],
                      color: percentageList[0] == null
                          ? Theme.of(context).colorScheme.onSurface
                          : Color(primary),
                      day: "S",
                    ),
                    Bar(
                        data: data[1],
                        height: percentageList[1],
                        color: percentageList[1] == null
                            ? Theme.of(context).colorScheme.onSurface
                            : Color(primary),
                        day: "T"),
                    Bar(
                        data: data[2],
                        height: percentageList[2],
                        color: percentageList[2] == null
                            ? Theme.of(context).colorScheme.onSurface
                            : Color(primary),
                        day: "Q"),
                    Bar(
                        data: data[3],
                        height: percentageList[3],
                        color: percentageList[3] == null
                            ? Theme.of(context).colorScheme.onSurface
                            : Color(primary),
                        day: "Q"),
                    Bar(
                        data: data[4],
                        height: percentageList[4],
                        color: percentageList[4] == null
                            ? Theme.of(context).colorScheme.onSurface
                            : Color(primary),
                        day: "S"),
                    Bar(
                        data: data[5],
                        height: percentageList[5],
                        color: percentageList[5] == null
                            ? Theme.of(context).colorScheme.onSurface
                            : Color(primary),
                        day: "S"),
                    Bar(
                        data: data[6],
                        height: percentageList[6],
                        color: percentageList[6] == null
                            ? Theme.of(context).colorScheme.onSurface
                            : Color(primary),
                        day: "D"),
                  ],
                ),
              ),
            ],
          ),
          const Positioned.fill(
            left: 30,
            top: 150,
            child: Divider(
              color: Color(0xFF5A6478),
            ),
          ),
        ],
      ),
    );
  }
}
