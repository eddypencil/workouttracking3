import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toastification/toastification.dart';

import '../../../consts/Colors.dart';
import '../../../consts/Icons.dart';
import '../../../consts/Regex.dart';
import '../../../models/blocs/cubit/AuthCubit/auth_cubit.dart';
import '../../../update/Model/widgets/CustomTextFormFeild.dart';


class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var authCubit = AuthCubit.get(context);
    return Stack(
      children: [
        Form(
          key: authCubit.formKey,
          child: Column(
            children: [
              CutomTextFromFeild(
                controller: authCubit.emailController,
                hintText: "Enter your email",
                labelText: "Email",
                suffix: SvgPicture.string(ICons.mailIcon),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  authCubit.emailController.text = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your email";
                  } else if (!RegExp(Regex.email).hasMatch(value)) {
                    return "Please enter valid email";
                  }
                  return null;
                },
                colorBorder: AppColors.red,
                obscureText: false,
                readOnly: false,
                autocorrect: true,
              ),
              CutomTextFromFeild(
                controller: authCubit.passwordController,
                hintText: "Enter your password",
                labelText: "Password",
                suffix: SvgPicture.string(ICons.lockIcon),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  authCubit.passwordController.text = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your password";
                  } else if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
                colorBorder: AppColors.red,
                obscureText: true,
                readOnly: false,
                autocorrect: false,
              ),
              CutomTextFromFeild(
                controller: authCubit.confirmPasswordController,
                hintText: "Re-enter your password",
                labelText: "Confirm Password",
                suffix: SvgPicture.string(ICons.lockIcon),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  authCubit.confirmPasswordController.text = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please re-enter your password";
                  } else if (value != authCubit.passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                colorBorder: AppColors.red,
                obscureText: true,
                readOnly: false,
                autocorrect: false,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  if (authCubit.formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true; // Show loading indicator
                    });
                    try {
                      await authCubit.signUpWithFire().then((value) async {
                        await authCubit.uploadImage(
                          image: authCubit.image!,
                          email: authCubit.signInEmailController.text,
                          uid: authCubit.currentUid,
                        );
                        authCubit.clearControllers();
                        toastification.show(
                          context: context,
                          title: const Text("Sign Up Success"),
                          animationDuration: const Duration(milliseconds: 300),
                          animationBuilder: (context, animation, alignment, child) {
                            return RotationTransition(
                              turns: animation,
                              child: child,
                            );
                          },
                        );
                        Navigator.pop(context); // Navigate back or wherever needed
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                    } finally {
                      setState(() {
                        isLoading = false; // Hide loading indicator
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFFFF7643),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
        if (isLoading)
          Column(
            children: [
              Center(
                  child: LoadingAnimationWidget.discreteCircle(color: AppColors.darkPrimaryColor, size: 100),
              ),
            ],
          ),
      ],
    );
  }
}
