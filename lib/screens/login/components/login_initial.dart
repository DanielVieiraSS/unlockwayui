// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unlockway/components/buttons.dart';
import 'package:unlockway/components/navigation.dart';
import 'package:unlockway/components/popups.dart';
import 'package:unlockway/handlers/login.handlers.dart';
import 'package:unlockway/screens/login/components/login_popup.dart';
import 'package:unlockway/screens/register/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialLogin extends StatefulWidget {
  const InitialLogin({super.key});

  @override
  State<InitialLogin> createState() => _InitialLoginState();
}

class _InitialLoginState extends State<InitialLogin> {
  //final FirebaseAuth auth = FirebaseAuth.instance;
  //User? user;

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    // auth.authStateChanges().listen((event) {
    //   setState(() {
    //     user = event;
    //   });
    // });
    getUserLogged();
  }

  getUserLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('Email');
    final String? password = prefs.getString('Password');

    if (email != null || password != null) {
      loginAPI(
        context,
        email!,
        password!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: Theme.of(context).colorScheme.outline == Colors.white
              ? Image.asset("assets/imgs/top_left_vector.png")
              : Image.asset("assets/imgs/top_left_vector_light.png"),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Theme.of(context).colorScheme.outline == Colors.white
              ? Image.asset("assets/imgs/bottom_right_vector.png")
              : Image.asset("assets/imgs/bottom_right_vector_light.png"),
        ),
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 70),
                  child: Theme.of(context).colorScheme.outline == Colors.white
                      ? SvgPicture.asset(
                          "assets/svgs/logo.svg",
                        )
                      : SvgPicture.asset(
                          "assets/svgs/logo_light.svg",
                        ),
                ),
                ButtonFilled(
                  text: "Entrar",
                  height: 48.0,
                  width: 240.0,
                  onTap: () {
                    modalBuilderBottomAnimation(
                      context,
                      const LoginPopup(),
                    );
                  },
                ),
                const SizedBox(height: 15),
                ButtonOutlined(
                  text: "Criar Conta",
                  height: 48.0,
                  width: 240.0,
                  onTap: () {
                    Navigator.of(context).push(
                      navigationPageRightAnimation(
                        const RegisterScreen(
                          googleEmail: null,
                          googleId: null,
                        ),
                      ),
                    );
                  },
                  color: Theme.of(context).colorScheme.primary,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 80.0, right: 20.0),
                        child: Divider(
                          color: Theme.of(context).colorScheme.outline,
                          height: 36,
                        ),
                      ),
                    ),
                    Text(
                      "Ou",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 80.0),
                        child: Divider(
                          color: Theme.of(context).colorScheme.outline,
                          height: 36,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: handleGoogleSignIn,
                  child: Container(
                    width: 240,
                    height: 48.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.outline,
                          spreadRadius: 0.5,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/imgs/google.png",
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Entrar com Google",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void handleGoogleSignIn() {
    try {
      // GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      // auth.signInWithProvider(googleAuthProvider).then((value) {}).then(
      //       (value) => loginGoogleAPI(
      //         context,
      //         email: user!.email,
      //         name: user!.displayName,
      //         password: user!.uid,
      //       ),
      //     );
    } catch (e) {
      // navigationPageRightAnimation(
      //   RegisterScreen(
      //     googleEmail: user!.email,
      //     googleId: user!.uid,
      //   ),
      // );
    }
  }
}
