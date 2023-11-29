import 'package:flutter/material.dart';
import 'package:unlockway/screens/notify/notifypage.dart';

class NotifyDetails extends StatelessWidget {
  const NotifyDetails({super.key, required this.text, required this.title});

  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Theme.of(context).colorScheme.outline,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "NOTIFICAÇÃO",
          style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontFamily: "Inter",
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontFamily: "Inter",
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const NotifyPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(
        -1.0,
        0.0,
      );
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
