import 'package:flutter/material.dart';

import 'package:inspection/inspection.dart';
import 'package:intl/intl.dart';
import 'package:ocean_common_module/ocean_common_module.dart';
import 'package:flutter_foodhub_app/flutter_foodhub_app.dart';

class RegisterFormWidget extends StatefulWidget {
  final TextEditingController fullNameController,
      emailController,
      passwordController;

  const RegisterFormWidget({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceSettingsProvider>(
      builder: (context, preferenceSettingsProvider, _) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccesorFormFiled(
              hintText: 'Your Name',
              darkTheme: preferenceSettingsProvider.isDarkTheme,
              controller: widget.fullNameController,
              validator: (e) => inspection(
                e,
                'required',
                message: 'Field is Required',
                locale: Intl.getCurrentLocale(),
              ),
              child: const FormLabelFieldWidget(
                label: 'Full Name',
              ),
            ),
            const SizedBox(height: 20.0),
            AccesorFormFiled(
              hintText: 'Your Email',
              darkTheme: preferenceSettingsProvider.isDarkTheme,
              controller: widget.emailController,
              textInputType: TextInputType.emailAddress,
              validator: (e) => inspection(
                e,
                'required|email',
                message: 'Field is Required & Type is Email',
                locale: Intl.getCurrentLocale(),
              ),
              child: const FormLabelFieldWidget(
                label: 'E-mail',
              ),
            ),
            const SizedBox(height: 20.0),
            AccesorFormFiled(
              hintText: 'Your Password',
              darkTheme: preferenceSettingsProvider.isDarkTheme,
              controller: widget.passwordController,
              obscureText: passwordVisible,
              showObscureToggle: true,
              onPressSufixobscureTextIcon: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              textInputAction: TextInputAction.done,
              validator: (e) => inspection(
                e,
                'required',
                message: 'Field is Required',
                locale: Intl.getCurrentLocale(),
              ),
              child: const FormLabelFieldWidget(
                label: 'Password',
              ),
            ),
          ],
        );
      },
    );
  }
}
