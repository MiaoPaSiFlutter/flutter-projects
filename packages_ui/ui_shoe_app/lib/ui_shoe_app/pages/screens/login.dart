import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/components_index.dart';
import '../constants/constants_index.dart';
import 'home/main_home.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _blurAnimationController;

  @override
  void initState() {
    _blurAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      lowerBound: 0,
      upperBound: 6,
    );
    super.initState();
    _blurAnimationController.forward();
    _blurAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _blurAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              Images.loginBg,
            ),
            fit: BoxFit.cover,
          )),
        ),
        BlurContainer(value: _blurAnimationController.value),
        SafeArea(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                double.infinity.widthBox,
                const Spacer(),
                const Spacer(),
                _buildTitleText(context),
                const Spacer(),
                const PrimaryTextField(
                  hintText: 'Name',
                  prefixIcon: Icons.person,
                ),
                24.heightBox,
                const PrimaryTextField(
                  hintText: 'Password',
                  isObscure: true,
                  prefixIcon: CupertinoIcons.padlock,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: const ButtonStyle(),
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    24.widthBox,
                  ],
                ),
                const Spacer(),
                AuthButton(
                    text: 'Sign In',
                    onPressed: () {
                      Navigator.of(context).pushNamed(UserDashboard.id);
                    }),
                const Spacer(),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Don\'t have an account?  ',
                        style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.onBackground)),
                    TextSpan(
                        text: 'Create',
                        style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed(SignUpScreen.id);
                          }),
                  ]),
                ),
              ],
            ).p(24),
          ),
        ),
      ]),
    );
  }

  Column _buildTitleText(BuildContext context) {
    return Column(
      children: [
        Text(
          'Hello',
          softWrap: true,
          style: TextStyle(
              fontSize: 85,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface),
        ),
        Text(
          'Sign in to your account',
          softWrap: true,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
