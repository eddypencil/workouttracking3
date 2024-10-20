import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// TODO: add flutter_svg package

import '../../../consts/Colors.dart';
import '../../../models/blocs/cubit/AuthCubit/auth_cubit.dart';
import 'Image_Section.dart';
import 'Sign_From.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AuthCubit(),
  child: Scaffold(

      backgroundColor: AppColors.backGround,

      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Register Account",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Complete your details or continue \nwith social media",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF757575)),
                  ),
                  // const SizedBox(height: 16),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    ImageSection()
                  ],),
                  const SignUpForm(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  RichText(
                    text: const TextSpan(
                      text:
                          "By continuing your confirm that you agree \nwith our Term and Condition",
                      style: TextStyle(color: Color(0xFF757575)),
                      children: [
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(color: Color(0xFFFF7643)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
);
  }
}

