import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/components_index.dart';
import '../constants/constants_index.dart';
import 'home/main_home.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = '/signup';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _blurAnimationController;

  @override
  void initState() {
    _blurAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      lowerBound: 0,
      upperBound: 45,
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
      resizeToAvoidBottomInset: false,
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
        BlurContainer(value: 50 - _blurAnimationController.value),
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
                24.heightBox,
                const PrimaryTextField(
                  hintText: 'Email address',
                  prefixIcon: CupertinoIcons.mail_solid,
                ),
                24.heightBox,
                const PrimaryTextField(
                  hintText: 'Phone',
                  prefixIcon: CupertinoIcons.phone_fill,
                ),
                const Spacer(),
                AuthButton(
                    text: 'Create',
                    onPressed: () {
                      Navigator.of(context).pushNamed(UserDashboard.id);
                    }),
                const Spacer(),
                Text('Or create account using social media',
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onBackground)),
                24.heightBox,
                const SocialIconButtonsRow(),
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
          'Create account',
          softWrap: true,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
