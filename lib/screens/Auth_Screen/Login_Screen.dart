import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../consts/Colors.dart';
import '../../consts/Icons.dart';
import '../../consts/Regex.dart';
import '../../models/blocs/cubit/AuthCubit/auth_cubit.dart';
import '../../update/Model/components/CustomText.dart';
import '../../update/Model/widgets/CustomTextFormFeild.dart';
import '../../view/menu/menu_view.dart';
import 'SignUpFrom/SignUp_Screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AuthCubit(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              var authCubit = AuthCubit.get(context);
              return Stack(
                fit: StackFit.expand,
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: constraints.maxHeight * 0.1),
                        const CustomText(
                          text: 'Get Started With Your Fitness Journey',
                          color: AppColors.white,
                          fontSize: 24,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.normal,
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        Form(
                          key: authCubit.signInFormKey,
                          child: Column(
                            children: [
                              CutomTextFromFeild(
                                controller: authCubit.signInEmailController,
                                hintText: 'Email',
                                labelText: 'Email',
                                colorBorder: AppColors.green,
                                suffix: SvgPicture.string(ICons.mailIcon),
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.go,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(Regex.email).hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  authCubit.signInEmailController.text = value;
                                },
                                obscureText: false,
                                readOnly: false,
                                autocorrect: true,
                              ),
                              CutomTextFromFeild(
                                controller: authCubit.signInPasswordController,
                                hintText: 'Password',
                                labelText: 'Password',
                                colorBorder: AppColors.green,
                                suffix: SvgPicture.string(ICons.lockIcon),
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  authCubit.signInPasswordController.text = value;
                                },
                                obscureText: true,
                                readOnly: false,
                                autocorrect: false,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (authCubit.signInFormKey.currentState!
                                      .validate()) {
                                    authCubit.signInWithFire().then((value){
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
  create: (context) => AuthCubit()..getUserInfoFire(),
  child: MenuView(),
),
                                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0xFF00BF6D),
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 48),
                                  shape: const StadiumBorder(),
                                ),
                                child: const Text("Sign in"),
                              ),
                              const SizedBox(height: 16.0),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.64),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => SignUpScreen(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text.rich(
                                  const TextSpan(
                                    text: "Don’t have an account? ",
                                    style: TextStyle(color: AppColors.darkTertiaryColor),
                                    children: [
                                      TextSpan(
                                        text: "Sign Up",
                                        style: TextStyle(color: Color(0xFF00BF6D)),
                                      ),
                                    ],
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.64),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],


                    ),


                  ),
                  // Gradient effect at the bottom of the screen
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 150,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF00BF6D), Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
