import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_stub/res/app_colors.dart';
import 'package:provider_stub/res/app_fonts.dart';
import 'package:provider_stub/res/app_strings.dart';
import 'package:provider_stub/screens/login/login_providers.dart';
import 'package:provider_stub/utils/skeleton.dart';
import 'package:provider_stub/widgets/custom_button.dart';
import 'package:provider_stub/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProviders(), // Provide the LoginProviders to the widget tree
      child: Consumer<LoginProviders>(
        builder: (context, loginProviders, _) {
          return buildBody(context, loginProviders);
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, LoginProviders loginProviders) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 60),
        child: Form(
          key: loginProviders.formKey,
          child: loginProviders.loading ? loginSkeleton() : ListView(
            children: [
              ...emailAndPasswordField(loginProviders),
              const SizedBox(height: 18.0),
              rememberMeButton(loginProviders),
              const SizedBox(height: 25.0),
              loginButton(context, loginProviders),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for email and password fields
  List<Widget> emailAndPasswordField(LoginProviders loginProviders) {
    return [
      Container(
        alignment: Alignment.centerLeft,
        child: const Text(
          AppStrings.email,
          style: AppFonts.textRegular17,
          textAlign: TextAlign.left,
        ),
      ),
      const SizedBox(height: 5.0),
      CustomTextField(
        controller: loginProviders.emailController,
        hintText: AppStrings.email,
      ),
      const SizedBox(height: 16.0),
      Container(
        alignment: Alignment.centerLeft,
        child: const Text(
          AppStrings.password,
          style: AppFonts.textRegular17,
          textAlign: TextAlign.left,
        ),
      ),
      const SizedBox(height: 5.0),
      CustomTextField(
        controller: loginProviders.passwordController,
        hintText: AppStrings.password,
      ),
    ];
  }

  // Widget for remember me checkbox
  Widget rememberMeButton(LoginProviders loginProviders) {
    return GestureDetector(
      onTap: () {
        loginProviders.rememberMe =
        !loginProviders.rememberMe; // Toggle rememberMe state
      },
      child: Row(
        children: [
          Container(
            width: 19,
            height: 19,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: loginProviders.rememberMe
                    ? Colors.transparent
                    : AppColors.primaryColor,
                width: 1.5,
              ),
              color: loginProviders.rememberMe
                  ? AppColors.primaryColor
                  : Colors.transparent,
            ),
            child: loginProviders.rememberMe
                ? const Center(
              child: Icon(
                Icons.check,
                size: 15,
                color: Colors.white,
              ),
            )
                : null,
          ),
          const SizedBox(width: 10.0),
          const Text(AppStrings.rememberMe),
        ],
      ),
    );
  }

  // Widget for login button
  Widget loginButton(BuildContext context, LoginProviders loginProviders) {
    return Center(
      child: CustomButton(
        onPressed: () {},
        text: AppStrings.login,
      ),
    );
  }

  // Widget to show loading skeleton
  Widget loginSkeleton() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeleton(height: 20, width: 100,), // Skeleton for title
        SizedBox(height: 5.0),
        Skeleton(height: 50, width: double.infinity,), // Skeleton for email field
        SizedBox(height: 16.0),
        Skeleton(height: 20, width: 100,), // Skeleton for title
        SizedBox(height: 5.0),
        Skeleton(height: 50, width: double.infinity,), // Skeleton for password field
        SizedBox(height: 25.0),
        Skeleton(height: 50, width: double.infinity,), // Skeleton for login button
      ],
    );
  }
}
