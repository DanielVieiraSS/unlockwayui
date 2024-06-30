import 'package:flutter/material.dart';
import 'package:unlockway/screens/login/components/login_initial.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const InitialLogin(),
      
    );
  }
}
