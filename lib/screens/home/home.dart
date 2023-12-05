// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unlockway/components/bottom_navigator.dart';
import 'package:unlockway/components/navigation.dart';
import 'package:unlockway/constants.dart';
import 'package:unlockway/handlers/history.handlers.dart';
import 'package:unlockway/handlers/home.handlers.dart';
import 'package:unlockway/handlers/routine.handlers.dart';
import 'package:unlockway/models/user.dart';
import 'package:unlockway/screens/home/components/create_buttons.dart';
import 'package:unlockway/screens/home/components/home_graph.dart';
import 'package:unlockway/screens/home/components/next_meals.dart';
import 'package:unlockway/screens/home/components/no_routine.dart';
import 'package:unlockway/screens/home/components/pending_actions.dart';
import 'package:unlockway/screens/notify/notifypage.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map homeData = {};
  dynamic actualRoutine;
  bool _isLoading = true;

  Future<void> fetchAnalysis() async {
    Map result = await getHomeAnalysysAPI(context);
    dynamic resultRoutine = await getRoutineOnUseAPI(context);
    setState(() {
      homeData = result;
      actualRoutine = resultRoutine;
      _isLoading = false;
    });
  }

  ingestMeal(
    String routineId,
    String mealId,
  ) async {
    await getHistoryIngestedAPI(
      context,
      routineId,
      mealId,
    ).then((value) => fetchAnalysis());
  }

  @override
  void initState() {
    super.initState();
    fetchAnalysis();
  }

  @override
  void dispose() {
    super.dispose();

    _isLoading = false;
    homeData = {};
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = userData;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: const UBottomNavigator("Home"),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 0,
                left: 20,
                right: 20,
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      user.photo != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              clipBehavior: Clip.hardEdge,
                              child: CachedNetworkImage(
                                imageUrl: user.photo as String,
                                fit: BoxFit.cover,
                                width: 64,
                                height: 64,
                                placeholder: (context, url) => CircleAvatar(
                                  backgroundColor: Color(primary),
                                  child: Text(
                                    (user.firstName!.substring(0, 1) +
                                            user.lastName!.substring(0, 1))
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 44.0,
                                      color: Color(dark),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 80,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Color(primary),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                (user.firstName!.substring(0, 1) +
                                        user.lastName!.substring(0, 1))
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 32.0,
                                  color: Color(dark),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Boa tarde,",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.outline),
                          ),
                          Text(
                            "${user.firstName} ${user.lastName}",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.outline),
                          ),
                        ],
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        navigationPageRightAnimation(
                          const NotifyPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.onBackground,
                      ),
                      padding: const MaterialStatePropertyAll(
                        EdgeInsets.all(8),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    icon: Icon(
                      Icons.notifications_none_outlined,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(13),
        child: SingleChildScrollView(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (homeData['meals'] == 0 || homeData['routines'] == 0)
                      Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          PendingActions(
                            meals: homeData['meals'],
                            routines: homeData['routines'],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    actualRoutine == null
                        ? const NoRoutineCard()
                        : Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Próximas Refeições",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              NextMeals(
                                  meals: actualRoutine['meals'],
                                  routineId: actualRoutine['id'],
                                  method: (String routineId, String mealId) {
                                    ingestMeal(routineId, mealId);
                                  }),
                            ],
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                    const CreateButtons(),
                    const SizedBox(
                      height: 32,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "CALORIAS POR DIA",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontFamily: "Inter",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    HomeGraph(
                      data: homeData['weekCalories'],
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/logo_mini.svg",
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              "Acompanha sua porcentagem de progresso conforme gerencia seus melhores hábitos.",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.outline),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
