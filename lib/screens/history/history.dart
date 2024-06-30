import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:unlockway/components/bottom_navigator.dart';
import 'package:unlockway/handlers/history.handlers.dart';
import 'package:unlockway/models/history.dart';
import 'package:unlockway/screens/history/components/history_card.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<HistoryModel> history = [];
  bool _isLoading = true;

  Future<void> fetchHistory() async {
    List<HistoryModel> result = await getHistoryAPI(context);

    setState(() {
      history = result;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchHistory();
    // print(homeData);
  }

  @override
  void dispose() {
    super.dispose();

    _isLoading = false;
    history;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: SafeArea(
          child: Container(
            margin:
                const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "HISTÓRICO",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : history.isNotEmpty
              ? LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: constraints.maxHeight),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 0.850,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              shrinkWrap: true,
                              itemCount: history.length,
                              itemBuilder: (context, index) {
                                HistoryModel actualHistory = history[index];
                                return HistoryCard(
                                  name: actualHistory.routineName,
                                  weekRepetitions: actualHistory.days,
                                  calories: actualHistory.calories,
                                  date: actualHistory.date,
                                  meals: actualHistory.ingestedMeals,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      PhosphorIcons.scroll(PhosphorIconsStyle.regular),
                      size: 150,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 28,
                      ),
                      child: SizedBox(
                        child: Text(
                          textAlign: TextAlign.center,
                          "Não há nenhum histórico atualmente, conforme o uso do app serão gerados relatórios sobre suas ações.",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontFamily: "Inter",
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
      bottomNavigationBar: const UBottomNavigator("History"),
    );
  }
}
