import 'package:flutter/material.dart';

import '../../compontents/compontents_index.dart';
import '../../tools/tools_index.dart';
import '../profile/complete_profile_screen.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "fitness_app/LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            children: [
              SizedBox(
                width: media.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: media.width * 0.03,
                    ),
                    const Text(
                      "Hey there,",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: media.width * 0.01),
                    const Text(
                      "Welcome Back",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 20,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: media.width * 0.05),
              RoundTextField(
                  hintText: "Email",
                  icon: Utils.assets("icons/message_icon.png"),
                  textInputType: TextInputType.emailAddress),
              SizedBox(height: media.width * 0.05),
              RoundTextField(
                hintText: "Password",
                icon: Utils.assets("icons/lock_icon.png"),
                textInputType: TextInputType.text,
                isObscureText: true,
                rightIcon: TextButton(
                    onPressed: () {},
                    child: Container(
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          Utils.assets("icons/hide_pwd_icon.png"),
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          color: AppColors.grayColor,
                        ))),
              ),
              SizedBox(height: media.width * 0.03),
              const Text("Forgot your password?",
                  style: TextStyle(
                    color: AppColors.grayColor,
                    fontSize: 10,
                  )),
              const Spacer(),
              RoundGradientButton(
                title: "Login",
                onPressed: () {
                  Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                },
              ),
              SizedBox(height: media.width * 0.01),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    width: double.maxFinite,
                    height: 1,
                    color: AppColors.grayColor.withOpacity(0.5),
                  )),
                  const Text("  Or  ",
                      style: TextStyle(
                          color: AppColors.grayColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                  Expanded(
                      child: Container(
                    width: double.maxFinite,
                    height: 1,
                    color: AppColors.grayColor.withOpacity(0.5),
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.primaryColor1.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Image.asset(
                        Utils.assets("icons/google_icon.png"),
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.primaryColor1.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Image.asset(
                        Utils.assets("icons/facebook_icon.png"),
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignupScreen.routeName);
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                            text: "Don’t have an account yet? ",
                          ),
                          TextSpan(
                              text: "Register",
                              style: TextStyle(
                                  color: AppColors.secondaryColor1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                        ]),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
